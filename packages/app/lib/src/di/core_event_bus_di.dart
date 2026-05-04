import 'package:app/src/di/service_locator.dart';
import 'package:core_event_bus/core_event_bus.dart';

Future<void> setupCoreEventBusDI() async {
  getIt.registerSingleton<AppEventBus>(AppEventBus());
}
