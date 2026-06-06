import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vanashree_ngo_application/config/router/route_names/route_names.dart';
import 'package:vanashree_ngo_application/features/app_start/utils/app_start_enums.dart';

abstract interface class AppStartNavigationService {
  void navigateBasedOnState(BuildContext context, AppStartState state);
}

class AppStartNavigationServiceImpl implements AppStartNavigationService {
  @override
  void navigateBasedOnState(BuildContext context, AppStartState state) {
    final route = _getRouteForState(state);
    if (route != null) {
      context.go(route);
    }
  }

  String? _getRouteForState(AppStartState state) {
    switch (state) {
      case AppStartState.onboarding:
        return RouteNames.onboarding;
      case AppStartState.unauthenticated:
        return RouteNames.auth.login; 
      case AppStartState.authenticated:
        return RouteNames.auth.login; 
      case AppStartState.noInternet:
        return RouteNames.auth.login; 
    }
  }
}
