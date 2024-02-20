import 'package:flutter/material.dart';

class Prof_First_Year extends StatefulWidget {
  const Prof_First_Year({Key? key, required this.fyclasses_subj})
      : super(key: key);

  final Map<String, List<String>> fyclasses_subj;

  @override
  State<Prof_First_Year> createState() => _Prof_First_YearState();
}

class _Prof_First_YearState extends State<Prof_First_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: widget.fyclasses_subj.length,
          itemBuilder: (BuildContext context, int index1) {
            final current_class = widget.fyclasses_subj.keys.elementAt(index1);
            final subjects = widget.fyclasses_subj.values.elementAt(index1);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
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
