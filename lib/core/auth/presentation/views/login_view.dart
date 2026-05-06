import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanashree_ngo_application/core/extensions/build_context_extensions.dart';

import '../../../../config/theme/providers/theme_provider.dart';
import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_icons.dart';
import '../../../common/constants/sizedbox_constants.dart';
import '../widgets/login_secondary_button.dart';

class LogInView extends ConsumerStatefulWidget {
  const LogInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInViewState();
}

class _LogInViewState extends ConsumerState<LogInView> {
  late final ValueNotifier<bool> _isPasswordVisible;
  late final GlobalKey<FormState> _formKey;
  @override
  void initState() {
    super.initState();
    _isPasswordVisible = ValueNotifier<bool>(false);
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _isPasswordVisible.dispose();
    _formKey.currentState?.dispose();
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
        endDrawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Dark theme'),
                  trailing: Consumer(
                    builder: (context, ref, child) {
                      final themeMode = ref.watch(themeModeProvider);
                      return Switch(
                        value: themeMode == ThemeMode.dark,
                        onChanged: (value) {
                          ref.read(themeModeProvider.notifier).toggleTheme();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 16.0),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.loginWelcome),
                const Spacing.vertical(24),
                Text(
                  'Welcome Back!',
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.titleTextColor,
                  ),
                ),
                const Spacing.vertical(8),
                Text(
                  'Continue your journey as a guardian of the grove.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: AppColors.bodyTextColor,
                  ),
                ),
                const Spacing.vertical(16),
                const Align(
                  alignment: Alignment.centerLeft,

                  child: Text('EMAIL OR MOBILE'),
                ),
                const Spacing.vertical(8),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'name@forest.org',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email or mobile number';
                    }

                    return null;
                  },
                ),
                const Spacing.vertical(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('PASSWORD'),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                const Spacing.vertical(8),
                ValueListenableBuilder(
                  valueListenable: _isPasswordVisible,
                  builder: (context, passwordVisible, child) {
                    return TextFormField(
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
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
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const Spacing.vertical(32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        // Perform login action
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Sign In   ",
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const WidgetSpan(
                              child: Icon(Icons.arrow_forward, size: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacing.vertical(32),
                const Text('OR CONTINUE WITH'),
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
                      const TextSpan(text: 'New to Vanashree? '),
                      WidgetSpan(
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to signup
                            // context.go('/signup');
                          },
                          child: Text(
                            'Sign up for an account',
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
