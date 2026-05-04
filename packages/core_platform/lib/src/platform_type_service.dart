import 'package:core_platform/src/platform_type.dart';
import 'package:core_platform/src/platform_type_error.dart';
import 'package:core_platform/src/platform_type_repository.dart';

class PlatformTypeService {
  factory PlatformTypeService() => _instance;

  PlatformTypeService._();

  static final PlatformTypeService _instance = PlatformTypeService._();
  static Future<PlatformTypeService>? _future;

  static PlatformType? _platform;
  static final _repository = PlatformTypeRepository();

  static Future<PlatformTypeService> getInstance() {
    _future ??= _create();
    return _future!;
  }

  static Future<PlatformTypeService> _create() async {
    _platform ??= await _repository.get();
    return _instance;
  }

  static bool get isAndroid => _platform == PlatformType.android;

  Future<void> set(PlatformType value) {
    _platform = value;
    return _repository.setPlatform(value);
  }

  static OUT execute<OUT>({OUT Function()? android, OUT Function()? iOS}) {
    if (_platform == PlatformType.android) {
      if (android != null) {
        return android.call();
      } else {
        throw PlatformTypeError();
      }
    } else if (_platform == PlatformType.iOS) {
      if (iOS != null) {
        return iOS.call();
      } else {
        throw PlatformTypeError();
      }
    } else {
      throw PlatformTypeError();
    }
  }
}
