import 'package:dio/dio.dart';

import '../../detail/domain/media_detail.dart';
import '../../home/domain/home_models.dart';
import '../../library/domain/library_models.dart';
import '../../player/domain/playback_models.dart';
import '../../search/domain/search_result_utils.dart';
import '../domain/media_server_adapter.dart';
import '../domain/server_models.dart';

class EmbyAdapter implements MediaServerAdapter {
  EmbyAdapter(this._dio);

  final Dio _dio;

  @override
  MediaServerType get serverType => MediaServerType.emby;

  @override
  Future<HomeFeed> fetchHome(MediaServerSession session) async {
    final resumeResponse = await _dio.get<Map<String, dynamic>>(
      '${session.server.baseUrl}/Users/${session.userId}/Items/Resume',
      options: Options(headers: _headers(session.accessToken)),
      queryParameters: const {
        'Limit': 12,
        'Recursive': true,
        'IncludeItemTypes': 'Movie,Episode,Video',
      },
    );

    final latestResponse = await _dio.get<List<dynamic>>(
      '${session.server.baseUrl}/Users/${session.userId}/Items/Latest',
      options: Options(headers: _headers(session.accessToken)),
      queryParameters: const {
        'Limit': 24,
        'IncludeItemTypes': 'Movie,Episode,Video',
      },
    );

    return HomeFeed(
      continueWatching: _itemsFromResponse(
        resumeResponse.data?['Items'] as List<dynamic>? ?? const [],
        session: session,
        serverId: session.server.id,
        fallbackLibraryId: 'resume',
      ),
      sections: [
        HomeSection(
          id: 'latest',
          title: 'Latest From Emby',
          items: _itemsFromResponse(
            latestResponse.data ?? const [],
            session: session,
            serverId: session.server.id,
            fallbackLibraryId: 'latest',
          ),
        ),
      ],
    );
  }

  @override
  Future<List<LibrarySummary>> fetchLibraries(
    MediaServerSession session,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '${session.server.baseUrl}/Users/${session.userId}/Views',
      options: Options(headers: _headers(session.accessToken)),
      queryParameters: const {
        'Fields': 'PrimaryImageAspectRatio,ImageTags,BackdropImageTags',
      },
    );

    final items = response.data?['Items'] as List<dynamic>? ?? const [];
    return items
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => LibrarySummary(
            id: item['Id']?.toString() ?? '',
            serverId: session.server.id,
            title: item['Name']?.toString() ?? 'Untitled Library',
            type: item['CollectionType']?.toString() ?? 'mixed',
            libraryImageUrl:
                _resolveBackdropImageUrl(session: session, item: item) ??
                _resolvePosterImageUrl(session: session, item: item) ??
                _resolveThumbImageUrl(session: session, item: item),
            itemCount: (item['ChildCount'] as num?)?.toInt() ?? 0,
          ),
        )
        .where((library) => library.id.isNotEmpty)
        .toList(growable: false);
  }

  @override
  Future<List<MediaItemSummary>> fetchItems({
    required MediaServerSession session,
    required String libraryId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '${session.server.baseUrl}/Users/${session.userId}/Items',
      options: Options(headers: _headers(session.accessToken)),
      queryParameters: {
        'ParentId': libraryId,
        'Recursive': true,
        'IncludeItemTypes': 'Movie,Episode,Video',
        'Fields':
            'Overview,MediaSources,UserData,ProductionYear,PrimaryImageAspectRatio,ImageTags,BackdropImageTags',
      },
    );

    return _itemsFromResponse(
      response.data?['Items'] as List<dynamic>? ?? const [],
      session: session,
      serverId: session.server.id,
      fallbackLibraryId: libraryId,
    );
  }

  @override
  Future<MediaDetail> fetchItemDetail({
    required MediaServerSession session,
    required String itemId,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '${session.server.baseUrl}/Users/${session.userId}/Items/$itemId',
      options: Options(headers: _headers(session.accessToken)),
      queryParameters: const {
        'Fields':
            'Overview,MediaSources,Genres,Studios,UserData,People,ProductionYear,PrimaryImageAspectRatio,ImageTags,BackdropImageTags',
      },
    );

    final data = response.data ?? const <String, dynamic>{};
    final mediaType = data['Type']?.toString() ?? 'Video';
    final isPlayableType = _isPlayableMediaType(mediaType);
    final playbackInfo = isPlayableType
        ? (await _dio.get<Map<String, dynamic>>(
                '${session.server.baseUrl}/Items/$itemId/PlaybackInfo',
                options: Options(headers: _headers(session.accessToken)),
                queryParameters: {
                  'UserId': session.userId,
                  'IsPlayback': true,
                  'AutoOpenLiveStream': true,
                  'StartTimeTicks': 0,
                },
              )).data ??
              const <String, dynamic>{}
        : const <String, dynamic>{};
    final playbackSource = isPlayableType
        ? _resolvePlaybackSource(
            session: session,
            itemId: itemId,
            playbackInfo: playbackInfo,
          )
        : _ResolvedPlaybackSource(
            uri: Uri.parse(''),
            mediaSourceId: null,
            playSessionId: null,
          );
    final playbackRuntimeSeconds =
        ((playbackSource.mediaSource?['RunTimeTicks'] as num?)?.toDouble() ??
            0) ~/
        10000000;
    return MediaDetail(
      id: itemId,
      serverId: session.server.id,
      title: data['Name']?.toString() ?? 'Untitled',
      overview:
          data['Overview']?.toString() ?? 'No overview returned from Emby.',
      posterImageUrl: _resolvePosterImageUrl(session: session, item: data),
      backdropImageUrl: _resolveBackdropImageUrl(session: session, item: data),
      thumbImageUrl: _resolveThumbImageUrl(session: session, item: data),
      runtimeSeconds:
          ((data['RunTimeTicks'] as num?)?.toDouble() ?? 0) ~/ 10000000 > 0
          ? (((data['RunTimeTicks'] as num?)?.toDouble() ?? 0) ~/ 10000000)
          : playbackRuntimeSeconds,
      resumePositionSeconds:
          ((data['UserData']?['PlaybackPositionTicks'] as num?)?.toDouble() ??
              0) ~/
          10000000,
      isFavorite: data['UserData']?['IsFavorite'] == true,
      year: (data['ProductionYear'] as num?)?.toInt(),
      genres: (data['Genres'] as List<dynamic>? ?? const [])
          .map((value) => value.toString())
          .toList(growable: false),
      mediaType: mediaType,
      streamUrl: isPlayableType ? playbackSource.uri.toString() : '',
      mediaSourceId: playbackSource.mediaSourceId,
      playSessionId: playbackSource.playSessionId,
    );
  }

  @override
  Future<List<MediaItemSummary>> searchItems({
    required MediaServerSession session,
    required String query,
    int limit = 50,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '${session.server.baseUrl}/Users/${session.userId}/Items',
      options: Options(headers: _headers(session.accessToken)),
      queryParameters: {
        'SearchTerm': query,
        'Recursive': true,
        'Limit': limit,
        'IncludeItemTypes': 'Series,Movie,Episode,Video',
        'Fields':
            'Overview,MediaSources,UserData,ProductionYear,PrimaryImageAspectRatio,ImageTags,BackdropImageTags,SortName',
      },
    );

    final mappedItems = _itemsFromResponse(
      response.data?['Items'] as List<dynamic>? ?? const [],
      session: session,
      serverId: session.server.id,
      fallbackLibraryId: 'search',
    );
    return refineSearchResults(mappedItems, query);
  }

  @override
  Future<void> reportPlayback({
    required MediaServerSession session,
    required PlaybackReport report,
  }) async {
    await _dio.post<void>(
      '${session.server.baseUrl}/Sessions/Playing/Progress',
      options: Options(headers: _headers(session.accessToken)),
      data: {
        'ItemId': report.itemId,
        'PositionTicks': report.positionSeconds * 10000000,
        'PlaySessionId': report.playSessionId,
        'MediaSourceId': report.mediaSourceId,
        'IsPaused': report.isPaused,
        'CanSeek': true,
      },
    );
  }

  @override
  Uri resolveStreamUrl({
    required MediaServerSession session,
    required String itemId,
    String? mediaSourceId,
    String? playSessionId,
  }) {
    final queryParameters = <String, String>{
      'static': 'true',
      'api_key': session.accessToken,
      if (mediaSourceId != null && mediaSourceId.isNotEmpty)
        'MediaSourceId': mediaSourceId,
      if (playSessionId != null && playSessionId.isNotEmpty)
        'PlaySessionId': playSessionId,
    };
    return Uri.parse(
      '${session.server.baseUrl}/Videos/$itemId/stream',
    ).replace(queryParameters: queryParameters);
  }

  _ResolvedPlaybackSource _resolvePlaybackSource({
    required MediaServerSession session,
    required String itemId,
    required Map<String, dynamic> playbackInfo,
  }) {
    final playSessionId = playbackInfo['PlaySessionId']?.toString();
    final mediaSources =
        (playbackInfo['MediaSources'] as List<dynamic>? ?? const [])
            .whereType<Map<String, dynamic>>()
            .toList(growable: false);
    final mediaSource = mediaSources.firstWhere(
      (candidate) =>
          candidate['SupportsDirectPlay'] == true ||
          candidate['SupportsDirectStream'] == true,
      orElse: () => mediaSources.isNotEmpty
          ? mediaSources.first
          : const <String, dynamic>{},
    );
    final mediaSourceId = mediaSource['Id']?.toString();
    final directStreamUrl = mediaSource['DirectStreamUrl']?.toString();
    final transcodingUrl = mediaSource['TranscodingUrl']?.toString();
    final resolvedUri =
        _resolvePlaybackUri(
          session: session,
          itemId: itemId,
          mediaSourceId: mediaSourceId,
          playSessionId: playSessionId,
          directStreamUrl: directStreamUrl,
          transcodingUrl: transcodingUrl,
        ) ??
        resolveStreamUrl(
          session: session,
          itemId: itemId,
          mediaSourceId: mediaSourceId,
          playSessionId: playSessionId,
        );

    return _ResolvedPlaybackSource(
      uri: resolvedUri,
      mediaSourceId: mediaSourceId,
      playSessionId: playSessionId,
      mediaSource: mediaSource.isEmpty ? null : mediaSource,
    );
  }

  Uri? _resolvePlaybackUri({
    required MediaServerSession session,
    required String itemId,
    String? mediaSourceId,
    String? playSessionId,
    String? directStreamUrl,
    String? transcodingUrl,
  }) {
    final candidate = _normalizePlaybackUrl(
      baseUrl: session.server.baseUrl,
      rawUrl: directStreamUrl,
      token: session.accessToken,
      mediaSourceId: mediaSourceId,
      playSessionId: playSessionId,
    );
    if (candidate != null) {
      return candidate;
    }

    return _normalizePlaybackUrl(
      baseUrl: session.server.baseUrl,
      rawUrl: transcodingUrl,
      token: session.accessToken,
      mediaSourceId: mediaSourceId,
      playSessionId: playSessionId,
    );
  }

  Uri? _normalizePlaybackUrl({
    required String baseUrl,
    required String token,
    String? rawUrl,
    String? mediaSourceId,
    String? playSessionId,
  }) {
    if (rawUrl == null || rawUrl.trim().isEmpty) {
      return null;
    }

    final resolved = Uri.parse(baseUrl).resolve(rawUrl);
    final query = Map<String, String>.from(resolved.queryParameters);
    if (!query.containsKey('api_key')) {
      query['api_key'] = token;
    }
    if (mediaSourceId != null &&
        mediaSourceId.isNotEmpty &&
        !query.containsKey('MediaSourceId')) {
      query['MediaSourceId'] = mediaSourceId;
    }
    if (playSessionId != null &&
        playSessionId.isNotEmpty &&
        !query.containsKey('PlaySessionId')) {
      query['PlaySessionId'] = playSessionId;
    }

    return resolved.replace(queryParameters: query);
  }

  Map<String, String> _headers(String token) {
    return {
      'X-Emby-Authorization':
          'MediaBrowser Client="Flumby", Device="Flumby", DeviceId="flumby-v1", Version="1.0.0", Token="$token"',
    };
  }

  @override
  Future<MediaServerSession> signIn(ServerSignInRequest request) async {
    final normalizedBaseUrl = request.baseUrl.replaceFirst(RegExp(r'/$'), '');
    final response = await _dio.post<Map<String, dynamic>>(
      '$normalizedBaseUrl/Users/AuthenticateByName',
      options: Options(
        headers: const {
          'Content-Type': 'application/json',
          'X-Emby-Authorization':
              'MediaBrowser Client="Flumby", Device="Flumby", DeviceId="flumby-v1", Version="1.0.0"',
        },
      ),
      data: {'Username': request.username, 'Pw': request.password},
    );

    final body = response.data ?? const <String, dynamic>{};
    final user =
        body['User'] as Map<String, dynamic>? ?? const <String, dynamic>{};
    final serverId = body['ServerId']?.toString().trim().isNotEmpty == true
        ? body['ServerId'].toString()
        : normalizedBaseUrl;
    final profile = MediaServerProfile(
      id: serverId,
      name: body['ServerName']?.toString() ?? 'Emby Server',
      baseUrl: normalizedBaseUrl,
      type: MediaServerType.emby,
      username: request.username,
      isOnline: true,
      updatedAt: DateTime.now().toUtc(),
    );

    return MediaServerSession(
      server: profile,
      accessToken: body['AccessToken']?.toString() ?? '',
      userId: user['Id']?.toString() ?? '',
    );
  }

  List<MediaItemSummary> _itemsFromResponse(
    List<dynamic> items, {
    required MediaServerSession session,
    required String serverId,
    required String fallbackLibraryId,
  }) {
    return items
        .whereType<Map<String, dynamic>>()
        .map(
          (item) => MediaItemSummary(
            id: item['Id']?.toString() ?? '',
            serverId: serverId,
            libraryId: item['ParentId']?.toString() ?? fallbackLibraryId,
            title: item['Name']?.toString() ?? 'Untitled',
            overview: item['Overview']?.toString() ?? 'No overview',
            posterImageUrl: _resolvePosterImageUrl(
              session: session,
              item: item,
            ),
            backdropImageUrl: _resolveBackdropImageUrl(
              session: session,
              item: item,
            ),
            thumbImageUrl: _resolveThumbImageUrl(session: session, item: item),
            runtimeSeconds:
                ((item['RunTimeTicks'] as num?)?.toDouble() ?? 0) ~/ 10000000,
            progress:
                (((item['UserData']?['PlayedPercentage'] as num?)?.toDouble() ??
                            0) /
                        100)
                    .clamp(0, 1),
            isFavorite: item['UserData']?['IsFavorite'] == true,
            isResumable:
                ((item['UserData']?['PlaybackPositionTicks'] as num?)
                        ?.toDouble() ??
                    0) >
                0,
            mediaType: item['Type']?.toString() ?? 'Video',
            seriesId: item['SeriesId']?.toString(),
            seriesTitle: item['SeriesName']?.toString(),
            year: (item['ProductionYear'] as num?)?.toInt(),
          ),
        )
        .where((item) => item.id.isNotEmpty)
        .toList(growable: false);
  }

  bool _isPlayableMediaType(String mediaType) {
    return switch (mediaType) {
      'Movie' || 'Episode' || 'Video' => true,
      _ => false,
    };
  }

  String? _resolvePosterImageUrl({
    required MediaServerSession session,
    required Map<String, dynamic> item,
  }) {
    final itemId = item['Id']?.toString();
    final primaryTag = _imageTag(item, 'Primary');
    if (itemId == null || itemId.isEmpty || primaryTag == null) {
      return null;
    }

    return _buildImageUrl(
      session: session,
      itemId: itemId,
      imageType: 'Primary',
      tag: primaryTag,
    );
  }

  String? _resolveThumbImageUrl({
    required MediaServerSession session,
    required Map<String, dynamic> item,
  }) {
    final itemId = item['Id']?.toString();
    final thumbTag = _imageTag(item, 'Thumb');
    if (itemId == null || itemId.isEmpty || thumbTag == null) {
      return null;
    }

    return _buildImageUrl(
      session: session,
      itemId: itemId,
      imageType: 'Thumb',
      tag: thumbTag,
    );
  }

  String? _resolveBackdropImageUrl({
    required MediaServerSession session,
    required Map<String, dynamic> item,
  }) {
    final itemId = item['Id']?.toString();
    final backdropTag = _backdropTag(item);
    if (itemId == null || itemId.isEmpty || backdropTag == null) {
      return null;
    }

    return _buildImageUrl(
      session: session,
      itemId: itemId,
      imageType: 'Backdrop',
      tag: backdropTag,
      imageIndex: 0,
    );
  }

  String? _imageTag(Map<String, dynamic> item, String key) {
    final imageTags = item['ImageTags'];
    if (imageTags is! Map) {
      return null;
    }

    final value = imageTags[key];
    final tag = value?.toString();
    if (tag == null || tag.isEmpty) {
      return null;
    }
    return tag;
  }

  String? _backdropTag(Map<String, dynamic> item) {
    final backdropTags = item['BackdropImageTags'];
    if (backdropTags is! List || backdropTags.isEmpty) {
      return null;
    }

    final tag = backdropTags.first?.toString();
    if (tag == null || tag.isEmpty) {
      return null;
    }
    return tag;
  }

  String _buildImageUrl({
    required MediaServerSession session,
    required String itemId,
    required String imageType,
    String? tag,
    int? imageIndex,
  }) {
    final path = imageIndex == null
        ? '/Items/$itemId/Images/$imageType'
        : '/Items/$itemId/Images/$imageType/$imageIndex';
    return Uri.parse('${session.server.baseUrl}$path')
        .replace(
          queryParameters: {
            'api_key': session.accessToken,
            if (tag != null && tag.isNotEmpty) 'tag': tag,
          },
        )
        .toString();
  }
}

class _ResolvedPlaybackSource {
  const _ResolvedPlaybackSource({
    required this.uri,
    this.mediaSourceId,
    this.playSessionId,
    this.mediaSource,
  });

  final Uri uri;
  final String? mediaSourceId;
  final String? playSessionId;
  final Map<String, dynamic>? mediaSource;
}
