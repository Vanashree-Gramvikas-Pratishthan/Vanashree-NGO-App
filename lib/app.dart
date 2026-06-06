import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vanashree_ngo_application/config/localization/l10n/app_localizations.dart';
import 'package:vanashree_ngo_application/config/router/app_router.dart';
import 'package:vanashree_ngo_application/config/theme/app_theme.dart';
import 'package:vanashree_ngo_application/config/theme/providers/theme_provider.dart';
import 'package:vanashree_ngo_application/features/localization/presentation/providers/language_view_model.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final localeState = ref.watch(languageViewModelProvider);
        final locale = localeState.value != null
            ? Locale(localeState.value!.code)
            : const Locale('en');
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Vanashree',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('hi'), // Hindi
            Locale('mr'), // Marathi
          ],
          locale: locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ref.watch(themeModeProvider),
          routerConfig: router,
        );
      },
    );
  }
}