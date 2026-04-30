import 'dart:io';

enum PlatformType {
  android,
  iOS;

  static PlatformType fromPlatform() {
    if (Platform.isAndroid) {
      return PlatformType.android;
    }

    if (Platform.isIOS) {
      return PlatformType.iOS;
    }

    throw Exception('Unsupported platform');
  }
}
