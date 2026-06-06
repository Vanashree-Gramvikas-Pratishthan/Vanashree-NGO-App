import 'package:get_it/get_it.dart';

import 'common/services/secure_storage_service.dart';
import 'utils/logger.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerSingleton<AppLogger>(AppLogger())
    ..registerSingleton<ISecureStorageService>(SecureStorageService());
  // getIt.registerSingleton<NetworkConnectivity>(NetworkConnectivity());
}

AppLogger get appLog => getIt<AppLogger>();
ISecureStorageService get secureStorage => getIt<ISecureStorageService>();
// NetworkConnectivity get networkConnection => getIt<NetworkConnectivity>();