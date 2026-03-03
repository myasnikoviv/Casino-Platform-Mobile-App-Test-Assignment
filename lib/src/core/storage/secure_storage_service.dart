import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Contract for secure key/value persistence.
abstract interface class CPSecureStorageService {
  /// Reads value by [key].
  Future<String?> read(String key);

  /// Writes [value] by [key].
  Future<void> write(String key, String value);

  /// Deletes value by [key].
  Future<void> delete(String key);
}

/// Flutter secure storage implementation.
class CPSecureStorageServiceImpl implements CPSecureStorageService {
  /// Creates [CPSecureStorageServiceImpl].
  const CPSecureStorageServiceImpl(this._storage);

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) {
    return _storage.read(key: key);
  }

  @override
  Future<void> write(String key, String value) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<void> delete(String key) {
    return _storage.delete(key: key);
  }
}
