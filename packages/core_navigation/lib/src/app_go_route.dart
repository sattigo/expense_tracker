import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppGoRoute extends GoRoute {
  AppGoRoute({
    required super.path,
    required super.name,
    required Widget Function(BuildContext context, GoRouterState state) builder,
    super.routes,
  }) : super(
         pageBuilder: (context, state) => NoTransitionPage(key: state.pageKey, child: builder(context, state)),
       );
}
