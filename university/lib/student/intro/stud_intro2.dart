import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/student/intro/stud_intro3.dart';

class Student_Intro2 extends StatefulWidget {
  const Student_Intro2({super.key});

  @override
  State<Student_Intro2> createState() => _Student_Intro2State();
}

class _Student_Intro2State extends State<Student_Intro2> {
  late SharedPreferences _prefs;
  String? _selectedBranch;
  String? email;

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email;

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
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

  Future<void> _saveSelectedBranch(String branch) async {
    await _prefs.setString('student${email}selectedBranch', branch);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Student_Intro3()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Which branch are you pursuing ?',
              style: _getTextStyle2(),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBranchButton('CMPN'),
                    _buildBranchButton('IT'),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBranchButton('MECH.'),
                    _buildBranchButton('INSTRU.'),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBranchButton('AI&DS'),
                    _buildBranchButton('AI&ML'),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBranchButton('EXTC'),
                    _buildBranchButton('ETRX'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchButton(String branch) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () => _saveSelectedBranch(branch),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 31, 1, 61),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(branch)),
    );
  }
}
