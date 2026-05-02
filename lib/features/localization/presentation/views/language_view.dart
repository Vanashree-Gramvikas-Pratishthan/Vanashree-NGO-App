import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vanashree_ngo_application/core/common/constants/constants.dart';

import '../../domain/entities/language.dart';
import '../providers/language_view_model.dart';

class LanguageView extends ConsumerWidget {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageViewModelProvider);
    final viewModel = ref.read(languageViewModelProvider.notifier);

    return languageState.when(
      data: (language) => Scaffold(
        appBar: AppBar(title: const Text('Select Language')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Current locale: ${language.code}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    viewModel.changeLanguage(const Language(Constants.en)),
                child: const Text('English'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    viewModel.changeLanguage(const Language(Constants.hi)),
                child: const Text('Hindi'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () =>
                    viewModel.changeLanguage(const Language(Constants.mr)),
                child: const Text('Marathi'),
              ),
            ],
          ),
        ),
      ),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Unable to load language: $error')),
      ),
    );
  }
}
