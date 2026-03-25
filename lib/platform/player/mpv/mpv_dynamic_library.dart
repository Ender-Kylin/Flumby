import 'dart:ffi';
import 'dart:io';

class MpvDynamicLibrary {
  static DynamicLibrary open() {
    final candidates = candidatePaths(
      operatingSystem: Platform.operatingSystem,
      resolvedExecutable: Platform.resolvedExecutable,
      currentDirectory: Directory.current.path,
      environmentMpvDir: Platform.environment['FLUMBY_MPV_DIR'],
    );

    Object? lastError;
    for (final candidate in candidates) {
      try {
        return DynamicLibrary.open(candidate);
      } catch (error) {
        lastError = error;
      }
    }

    throw ArgumentError.value(
      Platform.operatingSystem,
      'operatingSystem',
      'Unable to load libmpv: $lastError\n'
          'Searched paths:\n${candidates.map((value) => ' - $value').join('\n')}\n'
          'Bundle mpv into linux/third_party/mpv or windows/third_party/mpv, '
          'or point FLUMBY_MPV_DIR at a directory containing libmpv.',
    );
  }

  static List<String> candidatePaths({
    required String operatingSystem,
    required String resolvedExecutable,
    required String currentDirectory,
    String? environmentMpvDir,
  }) {
    final fileNames = switch (operatingSystem) {
      'windows' => const ['mpv-2.dll', 'libmpv-2.dll', 'mpv.dll'],
      'linux' => const ['libmpv.so.2', 'libmpv.so'],
      _ => const <String>[],
    };

    final executableFile = File(resolvedExecutable);
    final executableDirectory = executableFile.parent.absolute;
    final bundleRootDirectory = executableDirectory.absolute;
    final searchDirectories = <String>{
      if (environmentMpvDir != null && environmentMpvDir.trim().isNotEmpty)
        Directory(environmentMpvDir).absolute.path,
      executableDirectory.path,
      Directory(
        '${executableDirectory.path}${Platform.pathSeparator}lib',
      ).absolute.path,
      Directory(
        '${bundleRootDirectory.path}${Platform.pathSeparator}data',
      ).absolute.path,
      Directory(currentDirectory).absolute.path,
      Directory(
        '$currentDirectory${Platform.pathSeparator}$operatingSystem${Platform.pathSeparator}third_party${Platform.pathSeparator}mpv',
      ).absolute.path,
    };

    final candidates = <String>[];
    for (final directory in searchDirectories) {
      for (final fileName in fileNames) {
        candidates.add('$directory${Platform.pathSeparator}$fileName');
      }
    }

    candidates.addAll(fileNames);
    return candidates.toSet().toList(growable: false);
  }
}
