import '../../detail/domain/media_detail.dart';
import '../../home/domain/home_models.dart';
import '../../library/domain/library_models.dart';
import '../../player/domain/playback_models.dart';
import 'server_models.dart';

abstract interface class MediaServerAdapter {
  MediaServerType get serverType;

  Future<MediaServerSession> signIn(ServerSignInRequest request);

  Future<HomeFeed> fetchHome(MediaServerSession session);

  Future<List<LibrarySummary>> fetchLibraries(MediaServerSession session);

  Future<List<MediaItemSummary>> fetchItems({
    required MediaServerSession session,
    required String libraryId,
  });

  Future<List<MediaItemSummary>> searchItems({
    required MediaServerSession session,
    required String query,
    int limit = 50,
  });

  Future<MediaDetail> fetchItemDetail({
    required MediaServerSession session,
    required String itemId,
  });

  Future<void> reportPlayback({
    required MediaServerSession session,
    required PlaybackReport report,
  });

  Uri resolveStreamUrl({
    required MediaServerSession session,
    required String itemId,
    String? mediaSourceId,
    String? playSessionId,
  });
}
