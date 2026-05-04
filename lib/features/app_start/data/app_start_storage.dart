import '../../../core/common/constants/secure_storage_constants.dart';
import '../../../core/common/services/secure_storage_service.dart';

abstract interface class IAppStartStorage {
  Future<bool> loadOnboardingStatus();
  Future<void> saveOnboardingSeen();
}

class AppStartStorage implements IAppStartStorage {
  final ISecureStorageService _secureStorage;

  AppStartStorage(this._secureStorage);

  @override
  Future<bool> loadOnboardingStatus() async {
    final raw = await _secureStorage.getString(
      SecureStorageConstants.onboardingSeen,
    );
    return raw == 'true';
  }

  @override
  Future<void> saveOnboardingSeen() async {
    await _secureStorage.saveString(
      SecureStorageConstants.onboardingSeen,
      'true',
    );
  }
}
