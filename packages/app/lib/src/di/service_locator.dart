import 'package:app/src/di/core_event_bus_di.dart';
import 'package:app/src/di/features/chart_di.dart';
import 'package:app/src/di/features/expenses_di.dart';
import 'package:app/src/di/features/transaction_form_di.dart';
import 'package:app/src/di/router_di.dart';
import 'package:core_platform/core_platform.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  final platformTypeService = await PlatformTypeService.getInstance();
  getIt.registerSingleton<PlatformTypeService>(platformTypeService);

  await setupRouterDI();
  await setupCoreEventBusDI();
  await setupExpensesDI();
  await setupTransactionFormDI();
  await setupChartDI();
}
