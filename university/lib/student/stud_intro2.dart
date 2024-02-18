import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/student/stud_intro3.dart';

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
            const SizedBox(height: 35),
            Center(
              child: Container(
                height: 520,
                width: 250,
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                  ),
                  children: [
                    SizedBox(
                      height: 20,
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('CMPN'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('CMPN')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('IT'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('IT')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('MECH.'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('MECH.')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('INSTRU.'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('INSTRU.')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('AI&DS'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('AI&DS')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('AI&ML'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('AI&ML')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('EXTC'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('EXTC')),
                    ),
                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                          onPressed: () => _saveSelectedBranch('ETRX'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 31, 1, 61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                          ),
                          child: Text('ETRX')),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
