import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Prof_First_Year extends StatefulWidget {
  const Prof_First_Year({super.key, required this.fyclasses_subj});

  final Map<String, List<String>> fyclasses_subj; // Change the type here

  @override
  State<Prof_First_Year> createState() => _Prof_First_YearState();
}

class _Prof_First_YearState extends State<Prof_First_Year> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.fyclasses_subj.length,
                itemBuilder: (BuildContext context, int index1) {
                  final current_class =
                      widget.fyclasses_subj.keys.elementAt(index1);
                  final subjects = widget.fyclasses_subj.values
                      .elementAt(index1) as List<String>;
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: subjects.length,
                      itemBuilder: (BuildContext context, int index2) {
                        final current_subj = subjects[index2];

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0
                                ),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      current_class,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    Text(
                                      current_subj,
                                      style: const TextStyle(
                                          fontSize: 11, color: Colors.brown),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        );
                      });
                })
          ],
        ),
      ),
    );
  }
}
