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
<<<<<<< ours
<<<<<<< ours
    return {'profile': profile, 'meals': meals, 'weights': weights};
=======
=======
>>>>>>> theirs
    return {
      'profile': profile,
      'meals': meals,
      'weights': weights,
    };
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
  }

  factory AppBackup.fromMap(Map<String, dynamic> map) {
    return AppBackup(
<<<<<<< ours
<<<<<<< ours
      profile: map['profile'] as Map<String, dynamic>?,
=======
      profile: map['profile'] == null ? null : Map<String, dynamic>.from(map['profile'] as Map),
>>>>>>> theirs
=======
      profile: map['profile'] == null ? null : Map<String, dynamic>.from(map['profile'] as Map),
>>>>>>> theirs
      meals: ((map['meals'] as List?) ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
      weights: ((map['weights'] as List?) ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList(),
    );
  }
}
