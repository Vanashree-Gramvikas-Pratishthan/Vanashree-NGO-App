import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vanashree_ngo_application/features/localization/utils/language_code_enums.dart';

import 'config/localization/l10n/app_localizations.dart';
import 'config/router/app_router.dart';
import 'config/theme/app_theme.dart';
import 'config/theme/providers/theme_provider.dart';
import 'core/common/constants/constants.dart';
import 'core/locator.dart';
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
      builder: (_, ref, _) {
        final localeState = ref.watch(languageViewModelProvider);
        final locale = Locale(localeState.value?.code ?? Constants.en);
        final theme = ref.watch(themeModeProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: Constants.appName,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: LanguageCode.appLocales,
          locale: locale,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: theme,
          routerConfig: router,
        );
      },
    );
  }
}
