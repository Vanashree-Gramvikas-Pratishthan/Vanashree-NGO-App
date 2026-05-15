import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/views/login_view.dart';
import '../../../features/auth/presentation/views/signup_view2.dart';
import '../route_names/route_names.dart';

final authRoutes = [
  GoRoute(
    path: RouteNames.auth.login,
    builder: (context, state) => const LogInView(),
  ),
  GoRoute(
    path: RouteNames.auth.signup,
    builder: (context, state) => const SignUpView2(),
  ),
  // GoRoute(path: RouteNames.auth.register, builder: (context, state) => const RegisterView()),
  // GoRoute(path: RouteNames.auth.forgotPassword, builder: (context, state) => const ForgotPasswordView()),
];
