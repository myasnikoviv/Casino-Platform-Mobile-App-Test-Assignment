/// Generic in-memory cache with TTL-based invalidation.
class CPTtlCache<T> {
  T? _value;
  DateTime? _expiresAt;

  /// Returns cached value if still valid at current moment.
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

  /// Stores [value] for a specific [ttl] duration.
  void put(T value, Duration ttl) {
    _value = value;
    _expiresAt = DateTime.now().add(ttl);
  }

  /// Clears cache manually.
  void clear() {
    _value = null;
    _expiresAt = null;
  }
}
