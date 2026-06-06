import 'package:vanashree_ngo_application/features/app_start/domain/repositories/app_start_repository.dart';

import '../data_sources/app_start_storage.dart';

class AppStartRepositoryImpl implements AppStartRepository {
  final IAppStartStorage _storage;

  AppStartRepositoryImpl(this._storage);

  @override
  Future<bool> hasSeenOnboarding() {
    return _storage.loadOnboardingStatus();
  }

  @override
  Future<void> setOnboardingSeen() {
    return _storage.saveOnboardingSeen();
  }
}
