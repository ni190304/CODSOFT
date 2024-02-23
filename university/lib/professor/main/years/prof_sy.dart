import 'package:flutter/material.dart';
import 'package:university/professor/main/features/stud_display.dart';

class Prof_Second_Year extends StatefulWidget {
  const Prof_Second_Year({Key? key, required this.syclasses_subj})
      : super(key: key);

  final Map<String, List<String>> syclasses_subj;

  @override
  State<Prof_Second_Year> createState() => _Prof_Second_YearState();
}

class _Prof_Second_YearState extends State<Prof_Second_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Featured Classes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.syclasses_subj.length,
          itemBuilder: (BuildContext context, int index1) {
            final current_class = widget.syclasses_subj.keys.elementAt(index1);
            final subjects = widget.syclasses_subj.values.elementAt(index1);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Stud_Display(
                            classes: current_class,
                          ))),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.black,
                          width: 0.25,
                        ),
                      ),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              current_class,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.black),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: subjects
                                  .map((subject) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          subject,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.brown),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
