import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/start.dart';

import '../details.dart';

Map<String, List<String>> _classSelectedSubjects = {};

class Prof_Intro4 extends StatefulWidget {
  const Prof_Intro4({super.key});

  @override
  State<Prof_Intro4> createState() => _Prof_Intro4State();
}

class _Prof_Intro4State extends State<Prof_Intro4> {
  SharedPreferences? _prefs;
  List<String>? _selectedClasses;
  List<String>? _selectedBranches;
  List<String>? _selectedYears;

  String? email;

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _selectedClasses =
            _prefs!.getStringList('prof${email}selectedClasses') ?? [];
        _selectedYears =
            _prefs!.getStringList('prof${email}selectedYears') ?? [];
        _selectedBranches =
            _prefs!.getStringList('prof${email}selectedBranches') ?? [];
      });
    });

    super.initState();
  }

  void _toggleSubject(String _class, String subject) {
    setState(() {
      // Initialize the list for the class if it doesn't exist
      _classSelectedSubjects[_class] ??= [];

      // Toggle the subject in the list for the class
      if (_classSelectedSubjects[_class]!.contains(subject)) {
        _classSelectedSubjects[_class]!.remove(subject);
      } else {
        _classSelectedSubjects[_class]!.add(subject);
      }

      if (_classSelectedSubjects[_class]!.isEmpty) {
        _classSelectedSubjects.remove(_class);
      }
    });
  }

  void _saveAndProceed() async {
    String _classSelectedSubjectsJson = json.encode(_classSelectedSubjects);
    await _prefs!
        .setString('prof${email}selectedSubjects', _classSelectedSubjectsJson);

    await FirebaseFirestore.instance.collection('Professor').doc(email).set({
      'years': _selectedYears,
      'branches': _selectedBranches,
      'classSubjects': _classSelectedSubjectsJson
    });

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Start()));
  }

  TextStyle _getTextStyle2() {
    return GoogleFonts.katibeh(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 37,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Which subjects do you teach for each class ?',
              style: _getTextStyle2(),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: SubjectsList(
                onSave: _toggleSubject,
                selectedClasses: _selectedClasses ?? [],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 65,
              width: 220,
              child: ElevatedButton(
                onPressed: _saveAndProceed,
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black),
                child: const Text(
                  'Save and Proceed',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectsList extends StatefulWidget {
  final Function(String, String) onSave;
  final List<String> selectedClasses;

  SubjectsList({
    required this.onSave,
    required this.selectedClasses,
  });

  @override
  State<SubjectsList> createState() => _SubjectsListState();
}

class _SubjectsListState extends State<SubjectsList> {
  List<String> _getsubjects(String _class) {
    for (var yearItem in classinfo) {
      String year = yearItem['year'];
      List<Map<String, dynamic>> branches = yearItem['branches'];
      for (var branchItem in branches) {
        String branch = branchItem['branch'];
        List<String> classes = branchItem['classes'];
        if (classes.contains(_class)) {
          return branchItem['subjects'];
        }
      }
    }

    return [];
  }

  TextStyle _getTextStyle2() {
    return GoogleFonts.katibeh(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.selectedClasses.length,
      itemBuilder: (BuildContext context, int index) {
        final _class = widget.selectedClasses[index];

        List<String> subjects = _getsubjects(_class);

        Text(_class);

        const SizedBox(height: 20);

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Class : $_class ',
                style: _getTextStyle2(),
              ),
              const SizedBox(
                height: 50,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  final subject = subjects[index];
                  final isSelected =
                      (_classSelectedSubjects[_class] ?? []).contains(subject);

                  return Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                            onPressed: () => widget.onSave(_class, subject),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 30,
                              ),
                              foregroundColor:
                                  isSelected ? Colors.white : Colors.black,
                              backgroundColor: isSelected
                                  ? Color.fromARGB(255, 31, 1, 61)
                                  : Color.fromARGB(255, 132, 188, 234),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                            child: Text(subject)),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 45,
              )
            ],
          ),
        );
      },
    );
  }
}
