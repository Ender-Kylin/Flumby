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
      expect(
        queryParameters['IncludeItemTypes'],
        'Series,Movie,Episode,Video',
      );

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
}
