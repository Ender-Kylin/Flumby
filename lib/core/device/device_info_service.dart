import 'dart:io';

class DeviceInfoService {
  Future<String> provisionalDeviceId() async {
    final host = Platform.localHostname.replaceAll(
      RegExp(r'[^a-zA-Z0-9_-]'),
      '-',
    );
    return '${Platform.operatingSystem}-$host';
  }
}
