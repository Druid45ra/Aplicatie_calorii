import 'dart:async';

/// Performance utilities for optimization and caching
class PerformanceUtils {
  static final Map<String, CachedValue> _cache = {};

  /// Cache a value with automatic expiration
  static void cacheValue<T>(
    String key,
    T value, {
    required Duration duration,
  }) {
    _cache[key] = CachedValue(
      value: value,
      expiresAt: DateTime.now().add(duration),
    );
  }

  /// Retrieve a cached value if not expired
  static T? getCachedValue<T>(String key) {
    final cached = _cache[key];
    if (cached == null) return null;

    if (DateTime.now().isAfter(cached.expiresAt)) {
      _cache.remove(key);
      return null;
    }

    return cached.value as T?;
  }

  /// Clear specific cache entry
  static void clearCache(String key) => _cache.remove(key);

  /// Clear all cache
  static void clearAllCache() => _cache.clear();

  /// Debounce function calls
  static Timer? _debounceTimer;

  static void debounce(
    Duration duration,
    VoidCallback callback,
  ) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(duration, callback);
  }

  /// Cancel pending debounce
  static void cancelDebounce() => _debounceTimer?.cancel();
}

/// Internal class for cached values
class CachedValue {
  CachedValue({
    required this.value,
    required this.expiresAt,
  });

  final dynamic value;
  final DateTime expiresAt;
}
