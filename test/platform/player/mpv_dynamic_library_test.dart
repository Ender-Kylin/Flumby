import 'package:flumby/platform/player/mpv/mpv_dynamic_library.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('linux candidate paths prefer bundled runtime locations', () {
    final candidates = MpvDynamicLibrary.candidatePaths(
      operatingSystem: 'linux',
      resolvedExecutable: '/tmp/flumby/build/linux/x64/debug/bundle/flumby',
      currentDirectory: '/home/enderkylin/IdeaProjects/flumby',
      environmentMpvDir: '/opt/mpv',
    );

    expect(candidates, contains('/opt/mpv/libmpv.so.2'));
    expect(
      candidates,
      contains('/tmp/flumby/build/linux/x64/debug/bundle/lib/libmpv.so.2'),
    );
    expect(
      candidates,
      contains(
        '/home/enderkylin/IdeaProjects/flumby/linux/third_party/mpv/libmpv.so.2',
      ),
    );
  });
}
