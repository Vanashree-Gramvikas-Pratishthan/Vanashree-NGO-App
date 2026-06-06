import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vanashree_ngo_application/config/router/route_names/route_names.dart';
import 'package:vanashree_ngo_application/core/extensions/build_context_extensions.dart';

import '../../../../core/common/components/app_textfield.dart';
import '../../../../core/common/components/primary_button.dart';
import '../../../../core/common/constants/app_colors.dart';
import '../../../../core/common/constants/app_icons.dart';
import '../../../../core/common/constants/sizedbox_constants.dart';
import '../widgets/login_end_drawer.dart';
import '../widgets/login_secondary_button.dart';

class LogInView extends ConsumerStatefulWidget {
  const LogInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInViewState();
}

class _LogInViewState extends ConsumerState<LogInView> {
  late final ValueNotifier<bool> _isPasswordVisible;
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailOrPhoneController, _passwordController;
  @override
  void initState() {
    super.initState();
    _isPasswordVisible = ValueNotifier<bool>(false);
    _formKey = GlobalKey<FormState>();
    _emailOrPhoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    _formKey.currentState?.dispose();
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary, // or Colors.black
          ),
          title: Text(
            'Vanashree',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.primary,
            ),
          ),
          backgroundColor: context.theme.scaffoldBackgroundColor,
        ),
        endDrawer: const LoginEndDrawer(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.loginWelcome),
                const Spacing.vertical(24),
                Text(
                  context.l10n.welcome_back,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.titleTextColor,
                  ),
                ),
                const Spacing.vertical(8),
                Text(
                  context.l10n.login_message,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.bodyTextColor,
                  ),
                ),
                const Spacing.vertical(16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(context.l10n.email_or_mobile),
                ),
                const Spacing.vertical(8),
                AppTextField(
                  controller: _emailOrPhoneController,
                  hintText: 'name@forest.org',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return context
                          .l10n
                          .please_enter_your_email_or_mobile_number;
                    }

                    return null;
                  },
                ),
                const Spacing.vertical(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(context.l10n.password),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        context.l10n.forgot_password,
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                const Spacing.vertical(8),
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (context, passwordVisible, child) {
                    return AppTextField(
                      controller: _passwordController,
                      isObsecure: passwordVisible,
                      hintText: '********',
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _togglePasswordVisibility();
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.l10n.please_enter_your_password;
                        }
                        if (value.length < 6) {
                          return context
                              .l10n
                              .password_must_be_at_least_6_charecters_long;
                        }
                        return null;
                      },
                    );
                  },
                ),
                const Spacing.vertical(32),
                PrimaryButton(
                  backgroundColor: context.colorScheme.primary,
                  textColor: context.colorScheme.onPrimary,
                  title: context.l10n.sign_in,
                  suffixIcon: Icons.arrow_forward,
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.go(RouteNames.homepage.main);
                      // Process login
                    }
                  },
                ),
                const Spacing.vertical(32),
                Text(context.l10n.or_continue_with),
                const Spacing.vertical(32),
                const Row(
                  spacing: 32,
                  children: [
                    Expanded(
                      child: LoginSecondaryButton(
                        text: "Ecosystem",
                        iconPath: AppIcons.leafIcon,
                      ),
                    ),
                    Expanded(
                      child: LoginSecondaryButton(
                        text: "Guardian",
                        iconPath: AppIcons.cloudIcon,
                      ),
                    ),
                  ],
                ),
                const Spacing.vertical(40),
                RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: context.l10n.new_to_vanashree),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            context.push(RouteNames.auth.signup);
                          },
                          child: Text(
                            context.l10n.sign_up_for_an_account,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
