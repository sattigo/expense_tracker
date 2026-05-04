import 'package:core_platform/src/platform_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlatformTypeRepository {
  static const String _platformKey = 'platform';
  static const _kAndroid = 'android';
  static const _kIOS = 'ios';

  Future<SharedPreferences> _getPreferences() {
    return SharedPreferences.getInstance();
  }

  Future<PlatformType> get() async {
    final preferences = await _getPreferences();
    final currentValue = preferences.getString(_platformKey);

    switch (currentValue) {
      case _kAndroid:
        return PlatformType.android;
      case _kIOS:
        return PlatformType.iOS;
      default:
        final platform = PlatformType.fromPlatform();
        await setPlatform(platform);

        return platform;
    }
  }

  Future<void> setPlatform(PlatformType value) async {
    final preferences = await _getPreferences();
    String valueStr;

    switch (value) {
      case PlatformType.android:
        valueStr = _kAndroid;
      case PlatformType.iOS:
        valueStr = _kIOS;
    }

    await preferences.setString(_platformKey, valueStr);
  }
}
