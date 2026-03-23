import '../../../weight/domain/entities/weight_entry.dart';

class RemoteWeightEntryDto {
  const RemoteWeightEntryDto({
    required this.id,
    required this.weightKg,
    required this.date,
  });

  final String id;
  final double weightKg;
  final String date;

  factory RemoteWeightEntryDto.fromEntity(WeightEntry entity) {
    return RemoteWeightEntryDto(
      id: entity.id,
      weightKg: entity.weightKg,
      date: entity.date.toIso8601String(),
    );
  }

  WeightEntry toEntity() {
    return WeightEntry(
      id: id,
      weightKg: weightKg,
      date: DateTime.tryParse(date) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weightKg': weightKg,
      'date': date,
    };
  }

  factory RemoteWeightEntryDto.fromMap(Map<String, dynamic> map) {
    return RemoteWeightEntryDto(
      id: map['id'] as String? ?? '',
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
      date: map['date'] as String? ?? '',
    );
  }
}
