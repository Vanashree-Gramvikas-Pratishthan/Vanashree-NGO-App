import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vanashree_ngo_application/config/router/route_names/route_names.dart';
import 'package:vanashree_ngo_application/features/app_start/utils/app_start_enums.dart';

/// Service to handle app start navigation based on app state
abstract interface class AppStartNavigationService {
  void navigateBasedOnState(BuildContext context, AppStartState state);
}

/// Implementation of app start navigation service
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
        return RouteNames.language; // For now, go to language selection
      case AppStartState.authenticated:
        return RouteNames.language; // For now, go to language selection
      case AppStartState.noInternet:
        return RouteNames.language; // For now, go to language selection
    }
  }
}
