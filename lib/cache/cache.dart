import 'package:equatable/equatable.dart';

class CacheableData extends Equatable {
  final String key;
  final dynamic data;
  final DateTime expiryTime;

  const CacheableData(this.key, this.data, this.expiryTime);

  @override
  List<Object?> get props => [key, data, expiryTime];
}

class CachingDependency {
  final Map<String, CacheableData> _cache = {};

  dynamic get(String key) {
    final data = _cache[key];
    if (data != null && data.expiryTime.isBefore(DateTime.now())) {
      _cache.remove(key);
      return null;
    }
    return data?.data;
  }

  void set(String key, dynamic data, int ttlSeconds) {
    final expiryTime = DateTime.now().add(Duration(seconds: ttlSeconds));
    _cache[key] = CacheableData(key, data, expiryTime);
  }

  void invalidate(String key) {
    _cache.remove(key);
  }

  void clear() {
    _cache.clear();
  }

  void removeExpiredData() {
    final now = DateTime.now();
    _cache.removeWhere((key, data) => data.expiryTime.isBefore(now));
  }

// factory constructor
  CachingDependency._();
  static final CachingDependency _instance = CachingDependency._();
  factory CachingDependency() => _instance;
}

CachingDependency createCachingDependency() {
  return CachingDependency();
}
