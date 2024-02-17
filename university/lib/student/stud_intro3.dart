import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/details.dart';

class Student_Intro3 extends StatefulWidget {
  const Student_Intro3({Key? key}) : super(key: key);

  @override
  State<Student_Intro3> createState() => _Student_Intro3State();
}

class _Student_Intro3State extends State<Student_Intro3> {
  late SharedPreferences _prefs;
  late String _selectedYear;
  late String _selectedBranch;
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    _getStudentYear(email!);
    _getStudentBranch(email!);
  }

  Future<void> _getStudentYear(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedYear = _prefs.getString('${user_email}selectedYear') ?? '';
    });
  }

  Future<void> _getStudentBranch(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedBranch = _prefs.getString('${user_email}selectedBranch') ?? '';
    });
  }

  Future<void> _saveStudentData(String _selectedClass) async {
    _prefs.setString('${email}selectedClass', _selectedClass);
    await FirebaseFirestore.instance.collection('Student').doc(email).set({
      "year": _selectedYear,
      "branch": _selectedBranch,
      "class": _selectedClass
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Which class are you enrolled in ?'),
          const SizedBox(height: 50),
          ClassesList(
              studentYear: _selectedYear,
              studentBranch: _selectedBranch,
              onSave: _saveStudentData),
        ],
      ),
    );
  }
}

class ClassesList extends StatelessWidget {
  final String studentYear;
  final String studentBranch;
  final Function(String) onSave;

  ClassesList(
      {required this.studentYear,
      required this.studentBranch,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    final yearData = classinfo.firstWhere(
      (year) => year['year'] == studentYear,
      orElse: () => {},
    );

    final branchData = yearData['branches'].firstWhere(
      (branch) => branch['branch'] == studentBranch,
      orElse: () => {},
    );

    final List<String> classes = branchData['classes'];

    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () => onSave(classes[index]),
          child: Container(
            height: 20,
            width: 40,
            child: Center(child: Text(classes[index])),
          ),
        );
      },
    );
  }
}
