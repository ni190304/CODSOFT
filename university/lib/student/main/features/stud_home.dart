import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../info/details.dart';

class Stud_Home extends StatefulWidget {
  Stud_Home(
      {super.key,
      required this.selectedYear,
      required this.selectedBranch,
      required this.selectedClass});

  String? selectedYear;
  String? selectedBranch;
  String? selectedClass;

  @override
  State<Stud_Home> createState() => _Stud_HomeState();
}

Future<String?> getUsername(String email) async {
  final data =
      await FirebaseFirestore.instance.collection('User').doc(email).get();
  return data['username'];
}

Future<List<String>> getProfessorsWithEmail(
    String className, String subject) async {
  List<String> professorEmails = [];

  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Professor").get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      // Check if the document contains the specified years and branches
      if (data.containsKey("years") && data.containsKey("branches")) {
        List<String> docYears = List<String>.from(data["years"]);
        List<String> branches = List<String>.from(data["branches"]);
        print(docYears);
        print(branches);

        // Check if the document contains the specified classsubjects
        if (data.containsKey("classSubjects")) {
          String classSubjects = data["classSubjects"];
          print(classSubjects);

          Map<String, dynamic> decodedSubjects = json.decode(classSubjects);
          print(decodedSubjects);

          // Check if the classsubjects contains the specified classname and subject
          if (decodedSubjects.containsKey(className)) {
            List<dynamic> subjects = decodedSubjects[className]!;
            if (subjects.contains(subject)) {
              // Add the professor's email to the list
              String professorEmail =
                  doc.id; // Assuming email is the document ID
              professorEmails.add(professorEmail);
            }
          }
        }
      }
    });
  } catch (e) {
    print("Error fetching professors: $e");
  }

  return professorEmails;
}

class _Stud_HomeState extends State<Stud_Home> {
  @override
  Widget build(BuildContext context) {
    final yearData = classinfo.firstWhere(
      (year) => year['year'] == widget.selectedYear,
      orElse: () => {},
    );

    final branchData = yearData['branches']
        .firstWhere((branch) => branch['branch'] == widget.selectedBranch);

    final List<String> subjects = branchData['subjects'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Featured Subjects for ${widget.selectedClass}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index1) {
            final current_subject = subjects.elementAt(index1);

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            current_subject,
                            style: TextStyle(fontSize: 22, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10),
                          FutureBuilder(
                            future: getProfessorsWithEmail(
                                widget.selectedClass ?? '', current_subject),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Text('No professors found');
                              } else {
                                List<String> professorEmails = snapshot.data!;
                                if (professorEmails.isEmpty) {
                                  return Text('No professors found');
                                } else {
                                  String _email = professorEmails[0];
                                  return FutureBuilder(
                                    future: getUsername(_email),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        final username = snapshot.data;
                                        return Text("Professor: $username");
                                      }
                                    },
                                  );
                                }
                              }
                            },
                          )
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
