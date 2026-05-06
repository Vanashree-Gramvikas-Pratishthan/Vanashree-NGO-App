import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/localization/l10n/app_localizations.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/providers/theme_provider.dart';
import 'features/localization/presentation/providers/language_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: kDebugMode,
        builder: (context) {
          return const MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final localeState = ref.watch(languageViewModelProvider);
        final locale = localeState.value != null
            ? Locale(localeState.value!.code)
            : const Locale('en');
        final theme = ref.watch(themeModeProvider);
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
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: theme,
          routerConfig: router,
        );
      },
    );
  }
}
