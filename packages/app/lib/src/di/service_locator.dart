import 'package:app/src/di/features/expenses_di.dart';
import 'package:app/src/di/router_di.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  await setupRouterDI();
  await setupExpensesDI();
}
