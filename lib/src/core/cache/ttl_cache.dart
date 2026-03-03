import 'package:hive_flutter/hive_flutter.dart';

/// Generic TTL cache contract.
abstract interface class CPTtlCache<T> {
  /// Returns cached value if it is still valid.
  T? get();

  /// Persists [value] for [ttl] duration.
  void put(T value, Duration ttl);

  /// Clears cached value.
  void clear();
}

/// In-memory TTL cache implementation.
class CPMemoryTtlCache<T> implements CPTtlCache<T> {
  T? _value;
  DateTime? _expiresAt;

  @override
  T? get() {
    final DateTime? expiresAt = _expiresAt;
    if (_value == null || expiresAt == null) {
      return null;
    }
    if (DateTime.now().isAfter(expiresAt)) {
      _value = null;
      _expiresAt = null;
      return null;
    }
    return _value;
  }

  @override
  void put(T value, Duration ttl) {
    _value = value;
    _expiresAt = DateTime.now().add(ttl);
  }

  @override
  void clear() {
    _value = null;
    _expiresAt = null;
  }
}

/// Persistent Hive-backed TTL cache implementation.
class CPHiveTtlCache<T> implements CPTtlCache<T> {
  /// Creates [CPHiveTtlCache].
  const CPHiveTtlCache({
    required this.box,
    required this.cacheKey,
    required this.encode,
    required this.decode,
  });

  /// Hive box used for persistence.
  final Box<dynamic> box;

  /// Key of the cache entry in [box].
  final String cacheKey;

  /// Converts value to storable json-like structure.
  final Object? Function(T value) encode;

  /// Restores value from storable json-like structure.
  final T Function(Object? raw) decode;

  static const String _valueKey = 'value';
  static const String _expiresAtKey = 'expiresAt';

  @override
  T? get() {
    final dynamic rawEntry = box.get(cacheKey);
    if (rawEntry is! Map<dynamic, dynamic>) {
      return null;
    }

    final String? expiresAtRaw = rawEntry[_expiresAtKey] as String?;
    if (expiresAtRaw == null) {
      return null;
    }
    final DateTime? expiresAt = DateTime.tryParse(expiresAtRaw);
    if (expiresAt == null || DateTime.now().isAfter(expiresAt)) {
      clear();
      return null;
    }

    return decode(rawEntry[_valueKey]);
  }

  @override
  void put(T value, Duration ttl) {
    final Map<String, Object?> entry = <String, Object?>{
      _valueKey: encode(value),
      _expiresAtKey: DateTime.now().add(ttl).toIso8601String(),
    };
    box.put(cacheKey, entry);
  }

  @override
  void clear() {
    box.delete(cacheKey);
  }
}
