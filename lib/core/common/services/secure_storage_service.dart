import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ISecureStorageService {
  Future<void> saveString(String key, String value);
  Future<String?> getString(String key);
}

class SecureStorageService implements ISecureStorageService {
  static const _storage = FlutterSecureStorage();

  @override
  Future<void> saveString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }
}
