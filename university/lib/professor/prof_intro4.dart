import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../details.dart';

Map<String, List<String>> _classSelectedSubjects = {};

class Prof_Intro4 extends StatefulWidget {
  const Prof_Intro4({super.key});

  @override
  State<Prof_Intro4> createState() => _Prof_Intro4State();
}

class _Prof_Intro4State extends State<Prof_Intro4> {
  late SharedPreferences _prefs;
  List<String> _selectedClasses = [];
  List<String> _selectedBranches = [];
  List<String> _selectedYears = [];

  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
    _getProfClasses(email!);
    _getProfYears(email!);
    _getProfBranches(email!);
  }

  Future<void> _getProfClasses(String user_email) async {
    
    setState(() {
      _selectedClasses =
          _prefs.getStringList('prof${email}selectedClasses') ?? [];
    });
  }

  Future<void> _getProfYears(String user_email) async {
    
    setState(() {
      _selectedYears =
          _prefs.getStringList('prof${user_email}selectedYears') ?? [];
    });
  }

  Future<void> _getProfBranches(String user_email) async {
    
    setState(() {
      _selectedBranches =
          _prefs.getStringList('prof${user_email}selectedBranches') ?? [];
    });
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
    await _prefs.setString(
        'prof${email}selectedSubjects', _classSelectedSubjectsJson);

    await FirebaseFirestore.instance.collection('Professor').doc(email).set({
      'years': _selectedYears,
      'branches': _selectedBranches,
      'classSubjects': _classSelectedSubjectsJson
    });
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
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Which subjects do you teach for each class ?',
            style: _getTextStyle2(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SubjectsList(
              onSave: _toggleSubject,
              selectedClasses: _selectedClasses,
            ),
          ),
          ElevatedButton(
            onPressed: _saveAndProceed,
            child: Text('Save and Proceed'),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.selectedClasses.length,
      itemBuilder: (BuildContext context, int index) {
        final _class = widget.selectedClasses[index];

        List<String> subjects = _getsubjects(_class);

        Text(_class);

        const SizedBox(height: 20);

        return GridView.builder(
            itemCount: subjects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _buildSubjectButton(_class, subjects[index]);
            });
      },
    );
  }

  Widget _buildSubjectButton(String _class, String subject) {
    return ElevatedButton(
        onPressed: () => widget.onSave(_class, subject),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
          foregroundColor: _classSelectedSubjects[_class]!.contains(subject)
              ? Colors.white
              : Colors.black,
          backgroundColor: _classSelectedSubjects[_class]!.contains(subject)
              ? Color.fromARGB(255, 31, 1, 61)
              : Color.fromARGB(255, 132, 188, 234),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Text(subject));
  }
}
