import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Thin wrapper for secure key/value persistence.
class SecureStorageService {
  /// Creates secure storage service.
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  /// Reads value by [key] from secure storage.
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  /// Writes [value] by [key] into secure storage.
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  /// Deletes value by [key] from secure storage.
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }
}
