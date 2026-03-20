import 'package:equatable/equatable.dart';

class WeightEntry extends Equatable {
  const WeightEntry({
    required this.id,
    required this.weightKg,
    required this.date,
  });

  final String id;
  final double weightKg;
  final DateTime date;

  @override
  List<Object?> get props => [id, weightKg, date];
}
