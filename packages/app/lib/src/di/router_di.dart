import 'package:app/src/di/service_locator.dart';
import 'package:app/src/router/app_router_impl.dart';
import 'package:core_navigation/core_navigation.dart';

Future<void> setupRouterDI() async {
  getIt.registerLazySingleton<AppRouter>(AppRouterImpl.new);

  getIt.registerLazySingleton<GoRouter>(() => getIt<AppRouter>().router);
}
