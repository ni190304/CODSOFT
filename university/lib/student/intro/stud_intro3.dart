import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/details.dart';

import '../../auth/start.dart';

class Student_Intro3 extends StatefulWidget {
  const Student_Intro3({Key? key}) : super(key: key);

  @override
  State<Student_Intro3> createState() => _Student_Intro3State();
}

class _Student_Intro3State extends State<Student_Intro3> {
  SharedPreferences? _prefs;
  String? _selectedYear;
  String? _selectedBranch;
  String? email;

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _selectedYear = _prefs!.getString('student${email}selectedYear');
        _selectedBranch = _prefs!.getString('student${email}selectedBranch');
        print(_selectedYear);
        print(_selectedBranch);
      });
    });

    super.initState();
  }

  TextStyle _getTextStyle2() {
    return GoogleFonts.katibeh(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
    );
  }

  Future<void> _saveStudentData(String _selectedClass) async {
    _prefs!.setString('student${email}selectedClass', _selectedClass);
    await FirebaseFirestore.instance.collection('Student').doc(email).set({
      "year": _selectedYear,
      "branch": _selectedBranch,
      "class": _selectedClass
    });
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Start()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 125,
              ),
              Text(
                'Which class are you enrolled in ?',
                style: _getTextStyle2(),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: ClassesList(
                    studentYear: _selectedYear ?? '',
                    studentBranch: _selectedBranch ?? '',
                    onSave: _saveStudentData),
              ),
            ],
          ),
        ),
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
    // print(studentYear);
    final yearData = classinfo.firstWhere(
      (year) => year['year'] == studentYear,
      orElse: () => {},
    );

    if (yearData.isEmpty) {
      return Center(
        child: Text('No data available for selected year'),
      );
    }

    // Find the branch data for the selected branch
    final branchData = yearData['branches'].firstWhere(
      (branch) => branch['branch'] == studentBranch,
      orElse: () => <String, Object>{},
    );

    print('Branch Data: $branchData');

    if (branchData.isEmpty) {
      return Center(
        child: Text('No data available for selected branch'),
      );
    }

    final List<String> classes = branchData['classes'];

    return ListView.builder(
      itemCount: classes.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                  onPressed: () => onSave(classes[index]),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 31, 1, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: Text(classes[index])),
            ),
            SizedBox(
              height: 25,
            )
          ],
        );
      },
    );
  }
}
