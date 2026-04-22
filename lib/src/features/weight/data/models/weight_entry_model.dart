import '../../domain/entities/weight_entry.dart';

class WeightEntryModel extends WeightEntry {
  const WeightEntryModel({
    required super.id,
    required super.weightKg,
    required super.date,
  });

<<<<<<< ours
<<<<<<< ours
  Map<String, dynamic> toMap() {
    return {'id': id, 'weightKg': weightKg, 'date': date.toIso8601String()};
  }

  factory WeightEntryModel.fromMap(Map<dynamic, dynamic> map) {
    return WeightEntryModel(
      id: map['id'] as String? ?? '',
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
    );
  }

  factory WeightEntryModel.fromEntity(WeightEntry entity) {
    return WeightEntryModel(
      id: entity.id,
      weightKg: entity.weightKg,
      date: entity.date,
    );
  }
=======
=======
>>>>>>> theirs
  Map<String, dynamic> toMap() => {
        'id': id,
        'weightKg': weightKg,
        'date': date.toIso8601String(),
      };

  factory WeightEntryModel.fromMap(Map<dynamic, dynamic> map) => WeightEntryModel(
        id: map['id'] as String? ?? '',
        weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
        date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      );

  factory WeightEntryModel.fromEntity(WeightEntry entity) => WeightEntryModel(
        id: entity.id,
        weightKg: entity.weightKg,
        date: entity.date,
      );
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
}
