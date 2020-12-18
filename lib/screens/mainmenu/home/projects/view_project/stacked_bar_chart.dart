/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  StackedBarChart(this.seriesList, {this.animate});

  /// Creates a stacked [BarChart] with sample data and no transition.
  factory StackedBarChart.withSampleData() {
    return new StackedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<ChartModel, String>> _createSampleData() {
    final emptyData = [
      new ChartModel('Pekan 1', 30),
    ];
    final material1Data = [
      new ChartModel('Pekan 1', 40),
    ];

    final material2Data = [
      new ChartModel('Pekan 1', 10),
    ];

    final material3Data = [
      new ChartModel('Pekan 1', 20),
    ];

    return [
      new charts.Series<ChartModel, String>(
        id: 'empty',
        colorFn: (_, __) => charts.MaterialPalette.transparent,
        domainFn: (ChartModel empty, _) => empty.week,
        measureFn: (ChartModel empty, _) => empty.progress,
        data: emptyData,
      ),
      new charts.Series<ChartModel, String>(
        id: 'material 1',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.lighter,
        domainFn: (ChartModel material1, _) => material1.week,
        measureFn: (ChartModel material1, _) => material1.progress,
        data: material1Data,
      ),
      new charts.Series<ChartModel, String>(
        id: 'material 2',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (ChartModel material2, _) => material2.week,
        measureFn: (ChartModel material2, _) => material2.progress,
        data: material2Data,
      ),
      new charts.Series<ChartModel, String>(
        id: 'material 3',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault.darker,
        domainFn: (ChartModel material3, _) => material3.week,
        measureFn: (ChartModel material3, _) => material3.progress,
        data: material3Data,
      ),
    ];
  }
}

class ChartModel {
  final String week;
  final int progress;

  ChartModel(this.week, this.progress);
}
