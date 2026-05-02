import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vanashree_ngo_application/core/common/services/secure_storage_service.dart';
import 'package:vanashree_ngo_application/features/localization/data/language_repository.dart';
import 'package:vanashree_ngo_application/features/localization/data/language_storage.dart';
import 'package:vanashree_ngo_application/features/localization/domain/repositories/language_repository.dart';
import 'package:vanashree_ngo_application/features/localization/domain/usecases/load_language_use_case.dart';
import 'package:vanashree_ngo_application/features/localization/domain/usecases/save_language_use_case.dart';

final secureStorageServiceProvider = Provider<ISecureStorageService>((ref) {
  return SecureStorageService();
});

final languageStorageProvider = Provider<ILanguageStorage>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return LanguageStorage(secureStorage);
});

final languageRepositoryProvider = Provider<LanguageRepository>((ref) {
  final storage = ref.watch(languageStorageProvider);
  return LanguageRepositoryImpl(storage);
});

final loadLanguageUseCaseProvider = Provider<LoadLanguageUseCase>((ref) {
  return LoadLanguageUseCaseImpl(ref.watch(languageRepositoryProvider));
});

final saveLanguageUseCaseProvider = Provider<SaveLanguageUseCase>((ref) {
  return SaveLanguageUseCaseImpl(ref.watch(languageRepositoryProvider));
});
