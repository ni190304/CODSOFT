import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/student/stud_intro2.dart';

class Student_Intro1 extends StatefulWidget {
  const Student_Intro1({Key? key}) : super(key: key);

  @override
  State<Student_Intro1> createState() => _Student_Intro1State();
}

class _Student_Intro1State extends State<Student_Intro1> {
  late SharedPreferences _prefs;
  String? _selectedYear;
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
        fontSize: 37,
      ),
    );
  }

  Future<void> _saveSelectedYear(String year) async {
    await _prefs.setString('student${email}selectedYear', year);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Student_Intro2()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Which year are you currently studying in ?',
              style: _getTextStyle2(),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => _saveSelectedYear('F.E'),
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
                    child: Text('F.E'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => _saveSelectedYear('S.E'),
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
                    child: Text('S.E'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => _saveSelectedYear('T.E'),
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
                    child: Text('T.E'),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => _saveSelectedYear('B.E'),
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
                    child: Text('B.E'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
