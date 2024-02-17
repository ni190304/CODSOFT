import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/student/stud_intro3.dart';

class Student_Intro2 extends StatefulWidget {
  const Student_Intro2({super.key});

  @override
  State<Student_Intro2> createState() => _Student_Intro2State();
}

class _Student_Intro2State extends State<Student_Intro2> {
  late SharedPreferences _prefs;
  late String _selectedBranch;
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
  }

  Future<void> _saveSelectedBranch(String branch) async {
    await _prefs.setString('${email}selectedBranch', branch);

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Student_Intro3()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Which branch are you pursuing ?'),
          const SizedBox(height: 50),
          GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            children: [
              GestureDetector(
                onTap: () => _saveSelectedBranch('CMPN'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'CMPN' ? Colors.blue : null,
                  child: const Center(child: Text('CMPN')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('IT'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'IT' ? Colors.blue : null,
                  child: const Center(child: Text('IT')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('MECH.'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'MECH.' ? Colors.blue : null,
                  child: const Center(child: Text('MECH.')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('INSTRU.'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'INSTRU.' ? Colors.blue : null,
                  child: const Center(child: Text('INSTRU.')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('AI&DS'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'AI&DS' ? Colors.blue : null,
                  child: const Center(child: Text('AI&DS')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('AI&ML'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'AI&ML' ? Colors.blue : null,
                  child: const Center(child: Text('AI&ML')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('EXTC'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'EXTC' ? Colors.blue : null,
                  child: const Center(child: Text('EXTC')),
                ),
              ),
              GestureDetector(
                onTap: () => _saveSelectedBranch('ETRX'),
                child: Container(
                  height: 20,
                  width: 40,
                  color: _selectedBranch == 'ETRX' ? Colors.blue : null,
                  child: const Center(child: Text('ETRX')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
