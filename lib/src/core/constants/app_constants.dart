/// App-wide constants used by infrastructure and feature modules.
abstract final class CPAppConstants {
  /// Key used to persist a currently active session email.
  static const String sessionEmailKey = 'session_email';

  /// Key used to persist a biometric quick-login email.
  static const String biometricEmailKey = 'biometric_email';

  /// Hive box name where users are persisted.
  static const String usersBoxName = 'users_secure_box';

  /// Key for encrypted box cipher key in secure storage.
  static const String hiveCipherKeyStorageKey = 'hive_encryption_key';

  /// Hive box name for non-sensitive cached values.
  static const String cacheBoxName = 'cache_box';

  /// Hive cache key for games catalog snapshot.
  static const String gamesCacheKey = 'games_cache';

  /// TTL for game catalog cache.
  static const Duration gamesCacheTtl = Duration(minutes: 5);
}
