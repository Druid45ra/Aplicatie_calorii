import 'package:equatable/equatable.dart';

class AnalyticsSnapshot extends Equatable {
  const AnalyticsSnapshot({
    required this.averageCalories,
    required this.averageWeight,
    required this.weightChange,
    required this.adherenceRate,
  });

  final double averageCalories;
  final double averageWeight;
  final double weightChange;
  final double adherenceRate;

  @override
  List<Object?> get props => [averageCalories, averageWeight, weightChange, adherenceRate];

}
