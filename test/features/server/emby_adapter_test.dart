import 'package:dio/dio.dart';
import 'package:flumby/features/server/data/emby_adapter.dart';
import 'package:flumby/features/server/domain/server_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

void main() {
  setUpAll(() {
    registerFallbackValue(Options());
  });

  test('searchItems maps Emby item results into media summaries', () async {
    final dio = _MockDio();
    final adapter = EmbyAdapter(dio);
    final session = MediaServerSession(
      server: MediaServerProfile(
        id: 'emby-1',
        name: 'Local Emby',
        baseUrl: 'http://127.0.0.1:8096',
        type: MediaServerType.emby,
        username: 'tester',
        isOnline: true,
        updatedAt: DateTime.utc(2026, 3, 25),
      ),
      accessToken: 'token-123',
      userId: 'user-123',
    );

    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        options: any(named: 'options'),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      final path = invocation.positionalArguments.first as String;
      final queryParameters =
          invocation.namedArguments[#queryParameters]! as Map<String, dynamic>;

      expect(path, contains('/Users/user-123/Items'));
      expect(queryParameters['SearchTerm'], 'dune');
      expect(queryParameters['Recursive'], isTrue);
      expect(queryParameters['Limit'], 25);
      expect(queryParameters['IncludeItemTypes'], 'Series,Movie,Episode,Video');

      return Response(
        requestOptions: RequestOptions(path: path),
        data: {
          'Items': [
            {
              'Id': 'movie-1',
              'ParentId': 'library-1',
              'Name': 'Dune: Part Two',
              'Overview': 'Return to Arrakis.',
              'ImageTags': {'Primary': 'poster-tag', 'Thumb': 'thumb-tag'},
              'BackdropImageTags': ['backdrop-tag'],
              'RunTimeTicks': 99600000000,
              'ProductionYear': 2024,
              'UserData': {
                'PlayedPercentage': 38,
                'PlaybackPositionTicks': 1200000000,
                'IsFavorite': true,
              },
            },
          ],
        },
      );
    });

    final results = await adapter.searchItems(
      session: session,
      query: 'dune',
      limit: 25,
    );

    expect(results, hasLength(1));
    expect(results.first.id, 'movie-1');
    expect(results.first.serverId, 'emby-1');
    expect(results.first.libraryId, 'library-1');
    expect(results.first.title, 'Dune: Part Two');
    expect(results.first.progressPercent, 38);
    expect(results.first.isFavorite, isTrue);
    expect(results.first.isResumable, isTrue);
    expect(results.first.year, 2024);
    expect(
      results.first.posterImageUrl,
      contains('/Items/movie-1/Images/Primary'),
    );
    expect(results.first.posterImageUrl, contains('tag=poster-tag'));
    expect(
      results.first.thumbImageUrl,
      contains('/Items/movie-1/Images/Thumb'),
    );
    expect(
      results.first.backdropImageUrl,
      contains('/Items/movie-1/Images/Backdrop/0'),
    );
  });

  test(
    'fetchLibraries uses recursive media totals instead of ChildCount',
    () async {
      final dio = _MockDio();
      final adapter = EmbyAdapter(dio);
      final session = MediaServerSession(
        server: MediaServerProfile(
          id: 'emby-1',
          name: 'Local Emby',
          baseUrl: 'http://127.0.0.1:8096',
          type: MediaServerType.emby,
          username: 'tester',
          isOnline: true,
          updatedAt: DateTime.utc(2026, 3, 25),
        ),
        accessToken: 'token-123',
        userId: 'user-123',
      );

      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          options: any(named: 'options'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((invocation) async {
        final path = invocation.positionalArguments.first as String;
        final queryParameters =
            invocation.namedArguments[#queryParameters]
                as Map<String, dynamic>?;

        if (path.endsWith('/Users/user-123/Views')) {
          return Response(
            requestOptions: RequestOptions(path: path),
            data: {
              'Items': [
                {
                  'Id': 'library-anime',
                  'Name': '动漫',
                  'CollectionType': 'tvshows',
                  'ChildCount': 1,
                },
                {
                  'Id': 'library-movie',
                  'Name': '动画电影',
                  'CollectionType': 'movies',
                  'ChildCount': 1,
                },
              ],
            },
          );
        }

        if (path.endsWith('/Users/user-123/Items') &&
            queryParameters?['ParentId'] == 'library-anime') {
          expect(queryParameters?['Recursive'], isTrue);
          expect(queryParameters?['Limit'], 1);
          expect(queryParameters?['IncludeItemTypes'], 'Series,Movie,Video');
          return Response(
            requestOptions: RequestOptions(path: path),
            data: {
              'TotalRecordCount': 42,
              'Items': [
                {'Id': 'series-1'},
              ],
            },
          );
        }

        if (path.endsWith('/Users/user-123/Items') &&
            queryParameters?['ParentId'] == 'library-movie') {
          expect(queryParameters?['Recursive'], isTrue);
          expect(queryParameters?['Limit'], 1);
          expect(queryParameters?['IncludeItemTypes'], 'Series,Movie,Video');
          return Response(
            requestOptions: RequestOptions(path: path),
            data: {
              'TotalRecordCount': 18,
              'Items': [
                {'Id': 'movie-1'},
              ],
            },
          );
        }

        throw StateError('Unexpected path/query: $path / $queryParameters');
      });

      final libraries = await adapter.fetchLibraries(session);

      expect(libraries, hasLength(2));
      expect(libraries[0].title, '动漫');
      expect(libraries[0].itemCount, 42);
      expect(libraries[1].title, '动画电影');
      expect(libraries[1].itemCount, 18);
    },
  );

  test('fetchItems includes series entries for library browsing', () async {
    final dio = _MockDio();
    final adapter = EmbyAdapter(dio);
    final session = MediaServerSession(
      server: MediaServerProfile(
        id: 'emby-1',
        name: 'Local Emby',
        baseUrl: 'http://127.0.0.1:8096',
        type: MediaServerType.emby,
        username: 'tester',
        isOnline: true,
        updatedAt: DateTime.utc(2026, 3, 25),
      ),
      accessToken: 'token-123',
      userId: 'user-123',
    );

    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        options: any(named: 'options'),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      final path = invocation.positionalArguments.first as String;
      final queryParameters =
          invocation.namedArguments[#queryParameters]! as Map<String, dynamic>;

      expect(path, contains('/Users/user-123/Items'));
      expect(queryParameters['ParentId'], 'library-anime');
      expect(queryParameters['Recursive'], isTrue);
      expect(queryParameters['IncludeItemTypes'], 'Series,Movie,Video');

      return Response(
        requestOptions: RequestOptions(path: path),
        data: {
          'Items': [
            {
              'Id': 'series-1',
              'ParentId': 'library-anime',
              'Name': '药屋少女的呢喃',
              'Overview': 'Series overview.',
              'Type': 'Series',
              'ProductionYear': 2023,
              'ImageTags': {'Primary': 'series-poster'},
            },
          ],
        },
      );
    });

    final items = await adapter.fetchItems(
      session: session,
      libraryId: 'library-anime',
    );

    expect(items, hasLength(1));
    expect(items.single.id, 'series-1');
    expect(items.single.mediaType, 'Series');
    expect(items.single.title, '药屋少女的呢喃');
    expect(items.single.year, 2023);
    expect(
      items.single.posterImageUrl,
      contains('/Items/series-1/Images/Primary'),
    );
  });

  test('fetchItemDetail uses PlaybackInfo URLs and playback ids', () async {
    final dio = _MockDio();
    final adapter = EmbyAdapter(dio);
    final session = MediaServerSession(
      server: MediaServerProfile(
        id: 'emby-1',
        name: 'Local Emby',
        baseUrl: 'http://127.0.0.1:8096',
        type: MediaServerType.emby,
        username: 'tester',
        isOnline: true,
        updatedAt: DateTime.utc(2026, 3, 25),
      ),
      accessToken: 'token-123',
      userId: 'user-123',
    );

    when(
      () => dio.get<Map<String, dynamic>>(
        any(),
        options: any(named: 'options'),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((invocation) async {
      final path = invocation.positionalArguments.first as String;
      if (path.endsWith('/Users/user-123/Items/item-1')) {
        return Response(
          requestOptions: RequestOptions(path: path),
          data: {
            'Id': 'item-1',
            'Name': 'Episode 1',
            'Overview': 'Pilot.',
            'ImageTags': {'Primary': 'poster-tag', 'Thumb': 'thumb-tag'},
            'BackdropImageTags': ['backdrop-tag'],
            'RunTimeTicks': 36000000000,
            'Type': 'Episode',
            'Genres': ['Drama'],
            'UserData': {
              'PlaybackPositionTicks': 120000000,
              'IsFavorite': true,
            },
          },
        );
      }

      if (path.endsWith('/Items/item-1/PlaybackInfo')) {
        return Response(
          requestOptions: RequestOptions(path: path),
          data: {
            'PlaySessionId': 'play-123',
            'MediaSources': [
              {
                'Id': 'media-source-1',
                'SupportsDirectPlay': true,
                'DirectStreamUrl':
                    '/Videos/item-1/stream.mp4?Static=true&MediaSourceId=media-source-1',
              },
            ],
          },
        );
      }

      throw StateError('Unexpected path: $path');
    });

    final detail = await adapter.fetchItemDetail(
      session: session,
      itemId: 'item-1',
    );

    expect(detail.id, 'item-1');
    expect(detail.streamUrl, contains('/Videos/item-1/stream.mp4'));
    expect(detail.streamUrl, contains('MediaSourceId=media-source-1'));
    expect(detail.streamUrl, contains('PlaySessionId=play-123'));
    expect(detail.streamUrl, contains('api_key=token-123'));
    expect(detail.mediaSourceId, 'media-source-1');
    expect(detail.playSessionId, 'play-123');
    expect(detail.posterImageUrl, contains('/Items/item-1/Images/Primary'));
    expect(
      detail.backdropImageUrl,
      contains('/Items/item-1/Images/Backdrop/0'),
    );
    expect(detail.thumbImageUrl, contains('/Items/item-1/Images/Thumb'));
    expect(detail.isFavorite, isTrue);
  });

  test(
    'fetchItemDetail loads seasons and ordered episodes for series items',
    () async {
      final dio = _MockDio();
      final adapter = EmbyAdapter(dio);
      final session = MediaServerSession(
        server: MediaServerProfile(
          id: 'emby-1',
          name: 'Local Emby',
          baseUrl: 'http://127.0.0.1:8096',
          type: MediaServerType.emby,
          username: 'tester',
          isOnline: true,
          updatedAt: DateTime.utc(2026, 3, 25),
        ),
        accessToken: 'token-123',
        userId: 'user-123',
      );

      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          options: any(named: 'options'),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((invocation) async {
        final path = invocation.positionalArguments.first as String;
        final queryParameters =
            invocation.namedArguments[#queryParameters]
                as Map<String, dynamic>?;

        if (path.endsWith('/Users/user-123/Items/series-1')) {
          return Response(
            requestOptions: RequestOptions(path: path),
            data: {
              'Id': 'series-1',
              'Name': '斩神之凡尘神域',
              'Overview': 'Series overview.',
              'ImageTags': {
                'Primary': 'series-poster',
                'Thumb': 'series-thumb',
              },
              'BackdropImageTags': ['series-backdrop'],
              'ProductionYear': 2024,
              'Type': 'Series',
              'Genres': ['动画', 'Sci-Fi'],
            },
          );
        }

        if (path.endsWith('/Users/user-123/Items') &&
            queryParameters?['IncludeItemTypes'] == 'Season') {
          return Response(
            requestOptions: RequestOptions(path: path),
            data: {
              'Items': [
                {'Id': 'season-2', 'Name': 'Season 2', 'IndexNumber': 2},
                {'Id': 'season-1', 'Name': 'Season 1', 'IndexNumber': 1},
              ],
            },
          );
        }

        if (path.endsWith('/Users/user-123/Items') &&
            queryParameters?['IncludeItemTypes'] == 'Episode') {
          return Response(
            requestOptions: RequestOptions(path: path),
            data: {
              'Items': [
                {
                  'Id': 'episode-2',
                  'ParentId': 'season-1',
                  'Name': '第二集',
                  'Overview': 'Episode 2',
                  'ImageTags': {'Primary': 'ep2-poster'},
                  'IndexNumber': 2,
                  'ParentIndexNumber': 1,
                  'RunTimeTicks': 14400000000,
                  'UserData': {'PlayedPercentage': 12},
                },
                {
                  'Id': 'episode-1',
                  'ParentId': 'season-1',
                  'Name': '第一集',
                  'Overview': 'Episode 1',
                  'ImageTags': {'Primary': 'ep1-poster'},
                  'IndexNumber': 1,
                  'ParentIndexNumber': 1,
                  'RunTimeTicks': 14400000000,
                  'UserData': {
                    'PlaybackPositionTicks': 180000000,
                    'PlayedPercentage': 38,
                    'LastPlayedDate': '2026-03-24T12:00:00Z',
                  },
                },
                {
                  'Id': 'episode-3',
                  'ParentId': 'season-2',
                  'Name': '第一集',
                  'Overview': 'Season 2 episode 1',
                  'ImageTags': {'Primary': 'ep3-poster'},
                  'IndexNumber': 1,
                  'ParentIndexNumber': 2,
                  'RunTimeTicks': 14400000000,
                },
              ],
            },
          );
        }

        throw StateError('Unexpected path/query: $path / $queryParameters');
      });

      final detail = await adapter.fetchItemDetail(
        session: session,
        itemId: 'series-1',
      );

      expect(detail.mediaType, 'Series');
      expect(detail.isPlayable, isFalse);
      expect(detail.seriesSeasons, hasLength(2));
      expect(detail.seriesSeasons.first.seasonNumber, 1);
      expect(detail.seriesSeasons.first.episodes, hasLength(2));
      expect(detail.seriesSeasons.first.episodes.map((episode) => episode.id), [
        'episode-1',
        'episode-2',
      ]);
      expect(detail.seriesSeasons.first.episodes.first.isResumable, isTrue);
      expect(
        detail.seriesSeasons.first.episodes.first.lastPlayedAt,
        DateTime.utc(2026, 3, 24, 12),
      );
      expect(detail.seriesSeasons.last.seasonNumber, 2);
      expect(detail.seriesSeasons.last.episodes.single.id, 'episode-3');
    },
  );
}
