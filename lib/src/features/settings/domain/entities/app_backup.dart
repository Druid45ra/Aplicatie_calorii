class AppBackup {
  const AppBackup({
    required this.profile,
    required this.meals,
    required this.weights,
  });

  final Map<String, dynamic>? profile;
  final List<Map<String, dynamic>> meals;
  final List<Map<String, dynamic>> weights;

  Map<String, dynamic> toMap() {
    return {
      'profile': profile,
      'meals': meals,
      'weights': weights,
    };
  }

  factory AppBackup.fromMap(Map<String, dynamic> map) {
    return AppBackup(
      profile: map['profile'] == null
          ? null
          : Map<String, dynamic>.from(_asMap(map['profile'], 'profile')),
      meals: ((map['meals'] as List?) ?? const [])
          .map((item) => Map<String, dynamic>.from(_asMap(item, 'meals')))
          .toList(),
      weights: ((map['weights'] as List?) ?? const [])
          .map((item) => Map<String, dynamic>.from(_asMap(item, 'weights')))
          .toList(),
    );
  }
}

Map<dynamic, dynamic> _asMap(Object? value, String fieldName) {
  if (value is Map) {
    return value;
  }
  throw FormatException('Invalid backup field: $fieldName.');
}
