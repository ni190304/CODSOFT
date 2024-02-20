import 'package:flutter/material.dart';

class Prof_Fourth_Year extends StatefulWidget {
  const Prof_Fourth_Year({Key? key, required this.byclasses_subj})
      : super(key: key);

  final Map<String, List<String>> byclasses_subj;

  @override
  State<Prof_Fourth_Year> createState() => _Prof_Fourth_YearState();
}

class _Prof_Fourth_YearState extends State<Prof_Fourth_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Featured Classes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.byclasses_subj.length,
          itemBuilder: (BuildContext context, int index1) {
            final current_class = widget.byclasses_subj.keys.elementAt(index1);
            final subjects = widget.byclasses_subj.values.elementAt(index1);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 15),
                Container(
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
                            style: TextStyle(fontSize: 22, color: Colors.black),
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
                                            fontSize: 16, color: Colors.brown),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ],
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
