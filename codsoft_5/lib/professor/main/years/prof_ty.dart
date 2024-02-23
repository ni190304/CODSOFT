import 'package:flutter/material.dart';
import 'package:university/professor/main/features/stud_display.dart';

class Prof_Third_Year extends StatefulWidget {
  const Prof_Third_Year({Key? key, required this.tyclasses_subj})
      : super(key: key);

  final Map<String, List<String>> tyclasses_subj;

  @override
  State<Prof_Third_Year> createState() => _Prof_Third_YearState();
}

class _Prof_Third_YearState extends State<Prof_Third_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Featured Classes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.tyclasses_subj.length,
          itemBuilder: (BuildContext context, int index1) {
            final current_class = widget.tyclasses_subj.keys.elementAt(index1);
            final subjects = widget.tyclasses_subj.values.elementAt(index1);
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
                    height: 175,
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
