import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/providers/theme_provider.dart';
import '../../../localization/domain/entities/language.dart';
import '../../../localization/presentation/providers/language_view_model.dart';
import '../../../localization/utils/language_code_enums.dart';
import '../../../../core/common/constants/constants.dart';
import '../../../../core/extensions/build_context_extensions.dart';

class LoginEndDrawer extends ConsumerWidget {
  const LoginEndDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FocusScope.of(context).unfocus();
    final items = [
      DropdownMenuItem(
        value: LanguageCode.english.code,
        child: const Text(Constants.english),
      ),
      DropdownMenuItem(
        value: LanguageCode.hindi.code,
        child: const Text(Constants.hindi),
      ),
      DropdownMenuItem(
        value: LanguageCode.marathi.code,
        child: const Text(Constants.marathi),
      ),
      DropdownMenuItem(
        value: LanguageCode.nepali.code,
        child: const Text(Constants.nepali),
      ),
    ];
    final children = [
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
      ListTile(
        title: Text(context.l10n.language),
        trailing: SizedBox(
          width: 120,
          child: DropdownButton<String>(
            isExpanded: true,
            value:
                ref.watch(languageViewModelProvider).value?.code ??
                LanguageCode.english.code,
            items: items,
            onChanged: (value) async {
              final notifier = ref.read(languageViewModelProvider.notifier);

              await notifier.changeLanguage(Language(value!));

              if (context.mounted) {
                context.pop();
              }
            },
            hint: Text(context.l10n.select_language),
          ),
        ),
      ),
    ];

    return Drawer(
      width: context.width * .75,
      child: ListView(
        padding: const EdgeInsets.only(top: 48.0),
        children: children,
      ),
    );
  }
}
