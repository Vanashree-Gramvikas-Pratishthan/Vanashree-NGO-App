import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/common/pages/error_page.dart';
import '../../features/localization/presentation/views/language_view.dart';
import 'route_names/route_names.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RouteNames.startApp,
  navigatorKey: navigatorKey,
  routes: [
    GoRoute(
      path: RouteNames.startApp,
      builder: (context, state) => const LanguageView(),
    ),
  ],
  errorBuilder: (context, state) => ErrorPage(message: state.error!.message),
);
