import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quiz/bar_graph/bar_data.dart';
import 'package:quiz/screens/home.dart';

class MyBarGraph extends StatelessWidget {
  final List scores;
  const MyBarGraph({super.key, required this.scores});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        gk: scores[0],
        mv: scores[1],
        food: scores[2],
        sports: scores[3],
        music: scores[4],
        science: scores[5]);
    myBarData.initializeBarData();

    return BarChart(BarChartData(
        maxY: 5,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles)),
        ),
        barGroups: myBarData.scores
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      toY: data.y,
                      color: Colors.grey[800],
                      width: 25,
                      borderRadius: BorderRadius.circular(4),
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: 5, color: Colors.grey[200]))
                ]))
            .toList()));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);

    Widget ic;

    switch (value.toInt()) {
      case 0:
        ic = Icon(Icons.lightbulb);
        break;
      case 1:
        ic = Icon(Icons.movie);
        break;
      case 2:
        ic = Icon(Icons.food_bank);
        break;
      case 3:
        ic = Icon(Icons.sports_baseball);
        break;
      case 4:
        ic = Icon(Icons.music_note);
        break;
      case 5:
        ic = Icon(Icons.science);
        break;
      default:
        ic = Text(
          '',
          style: style,
        );
        break;
    }
    return SideTitleWidget(child: ic, axisSide: meta.axisSide);
  }
}
