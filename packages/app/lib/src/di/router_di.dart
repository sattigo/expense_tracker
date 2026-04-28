import 'package:core_navigation/core_navigation.dart';
import '../router/app_router_impl.dart';
import 'service_locator.dart';

Future<void> setupRouterDI() async {
  getIt.registerLazySingleton<AppRouter>(() => AppRouterImpl());

  getIt.registerLazySingleton<GoRouter>(() => getIt<AppRouter>().router);
}
