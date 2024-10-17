import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SalesChart extends StatelessWidget {
  final Map<String, double> salesData;

  SalesChart({required this.salesData});

  @override
  Widget build(BuildContext context) {
    // Prepare the data for the chart
    final List<Map<String, dynamic>> chartData = salesData.entries
        .map((entry) => {
              'date': DateTime.parse(entry.key),
              'sales': entry.value,
            })
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Chart')),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Last 7 days Selling",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height /
                3, // Set height to half of the screen
            padding: const EdgeInsets.all(16.0),
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat('dd MMM'), // Format the x-axis
                interval: 1, // Show all dates
                labelRotation: -45, // Rotate labels for better visibility
                majorGridLines:
                    const MajorGridLines(width: 0), // Hide grid lines
                title: const AxisTitle(text: 'Date'),
              ),
              primaryYAxis: const NumericAxis(
                title: AxisTitle(text: 'Sales (in Rupee ₹)'),
                interval: 5000, // Set interval for y-axis
              ),
              series: <CartesianSeries>[
                ColumnSeries<Map<String, dynamic>, DateTime>(
                  color: Colors.amber,
                  dataSource: chartData,
                  xValueMapper: (data, _) => data['date'],
                  yValueMapper: (data, _) => data['sales'],
                  name: 'Sales',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
