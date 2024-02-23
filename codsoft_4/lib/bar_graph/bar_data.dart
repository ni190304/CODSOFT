import 'package:quiz/bar_graph/ind_bar.dart';

class BarData {
  final double gk;
  final double mv;
  final double food;
  final double sports;
  final double music;
  final double science;

  BarData(
      {required this.gk,
      required this.mv,
      required this.food,
      required this.sports,
      required this.music,
      required this.science});

  List<IndivisualBar> scores = [];

  void initializeBarData() {
    scores = [
      IndivisualBar(x: 0, y: gk),
      IndivisualBar(x: 1, y: mv),
      IndivisualBar(x: 2, y: food),
      IndivisualBar(x: 3, y: sports),
      IndivisualBar(x: 4, y: music),
      IndivisualBar(x: 5, y: science),
    ];
  }
}
