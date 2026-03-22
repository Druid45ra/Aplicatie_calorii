import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/weight_entry.dart';

class WeightLineChart extends StatelessWidget {
  const WeightLineChart({
    required this.entries,
    super.key,
  });

  final List<WeightEntry> entries;

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return const SizedBox.shrink();
    }

    final sorted = [...entries]..sort((a, b) => a.date.compareTo(b.date));

    final spots = <FlSpot>[];
    for (var index = 0; index < sorted.length; index++) {
      spots.add(
        FlSpot(
          index.toDouble(),
          sorted[index].weightKg,
        ),
      );
    }

    final minY = sorted
            .map((entry) => entry.weightKg)
            .reduce((a, b) => a < b ? a : b) -
        1;

    final maxY = sorted
            .map((entry) => entry.weightKg)
            .reduce((a, b) => a > b ? a : b) +
        1;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              minY: minY,
              maxY: maxY,
              gridData: const FlGridData(show: true),
              borderData: FlBorderData(show: false),
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
                    interval: sorted.length > 1 ? 1 : 1,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= sorted.length) {
                        return const SizedBox.shrink();
                      }

                      final date = sorted[index].date;
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '${date.day}/${date.month}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  barWidth: 3,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(show: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
