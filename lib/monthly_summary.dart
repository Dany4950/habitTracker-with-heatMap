import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/date.time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int> dataset;
  final String startDate;
  const MonthlySummary(
      {required this.dataset, required this.startDate, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HeatMap(
        defaultColor: Colors.white,
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days: 30)),
        colorMode: ColorMode.color,
        textColor: Colors.black,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size: 30,
        datasets: dataset,
        colorsets: const {
          1: Color(0xffebf5eb), // Lightest green (almost white)
          3: Color(0xff9be9a8), // Light green
          5: Color(0xff40c463), // Medium green
          7: Color(0xff30a14e), // Dark green
          9: Color(0xff216e39), // Darker green
          11: Color(0xff161b22), // Darkest green (almost black)
          13: Color(0xff0e4429), // Deep forest green
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
