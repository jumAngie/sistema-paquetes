import 'package:flutter/material.dart';
import 'package:flutter_paqueteria/navigation/bottomnavigation.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graficos extends StatelessWidget {
 const Graficos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BNavigator(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Gráfico de barras'),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: _buildBarChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    final List<ChartData> data = [
      ChartData('Enero', 5),
      ChartData('Febrero', 10),
      ChartData('Marzo', 15),
      ChartData('Abril', 20),
      ChartData('Mayo', 25),
    ];

    final series = [
      charts.Series(
        id: 'Valores',
        data: data,
        domainFn: (ChartData values, _) => values.month,
        measureFn: (ChartData values, _) => values.value,
      ),
    ];

    return charts.BarChart(
      series,
      animate: true,
    );
  }
}

class ChartData {
  final String month;
  final int value;

  ChartData(this.month, this.value);
}
