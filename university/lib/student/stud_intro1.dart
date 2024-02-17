import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/student/stud_intro2.dart';

class Student_Intro1 extends StatefulWidget {
  const Student_Intro1({Key? key}) : super(key: key);

  @override
  State<Student_Intro1> createState() => _Student_Intro1State();
}

class _Student_Intro1State extends State<Student_Intro1> {
  late SharedPreferences _prefs;
  late String _selectedYear;
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
  }

  Future<void> _saveSelectedYear(String year) async {
    await _prefs.setString('student${email}selectedYear', year);

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Student_Intro2()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Which year are you currently studying in ?'),
          const SizedBox(height: 50),
          Column(
            children: [
              GestureDetector(
                onTap: () => _saveSelectedYear('F.E'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedYear == 'F.E' ? Colors.blue : null,
                  child: const Center(child: Text('F.E')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedYear('S.E'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedYear == 'S.E' ? Colors.blue : null,
                  child: const Center(child: Text('S.E')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedYear('T.E'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedYear == 'T.E' ? Colors.blue : null,
                  child: const Center(child: Text('T.E')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedYear('B.E'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedYear == 'B.E' ? Colors.blue : null,
                  child: const Center(child: Text('B.E')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
