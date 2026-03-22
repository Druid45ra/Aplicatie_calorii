import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../tracking/domain/entities/meal_entry.dart';

class CalorieBarChart extends StatelessWidget {
  const CalorieBarChart({required this.meals, super.key});

  final List<MealEntry> meals;

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const SizedBox.shrink();
    }

    final grouped = <String, int>{};

    for (final meal in meals) {
      final key = '${meal.date.day}/${meal.date.month}';
      grouped.update(
        key,
        (value) => value + meal.calories,
        ifAbsent: () => meal.calories,
      );
    }

    final entries = grouped.entries.toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 240,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(show: false),
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 42),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= entries.length) {
                        return const SizedBox.shrink();
                      }

                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          entries[index].key,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ),
              ),
              barGroups: List.generate(entries.length, (index) {
                final item = entries[index];

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: item.value.toDouble(),
                      width: 18,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
