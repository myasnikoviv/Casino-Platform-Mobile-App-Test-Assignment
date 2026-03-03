/// App-wide constants used by infrastructure and feature modules.
abstract final class CPAppConstants {
  /// Key used to persist a currently active session email.
  static const String sessionEmailKey = 'session_email';

  /// Hive box name where users are persisted.
  static const String usersBoxName = 'users_secure_box';

  /// Key for encrypted box cipher key in secure storage.
  static const String hiveCipherKeyStorageKey = 'hive_encryption_key';

  /// TTL for game catalog cache.
  static const Duration gamesCacheTtl = Duration(minutes: 5);
}
