import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/intro/prof_intro2.dart';

class Prof_Intro1 extends StatefulWidget {
  const Prof_Intro1({Key? key}) : super(key: key);

  @override
  State<Prof_Intro1> createState() => _Prof_Intro1State();
}

class _Prof_Intro1State extends State<Prof_Intro1> {
  late SharedPreferences _prefs;
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
  }

  TextStyle _getTextStyle2() {
    return GoogleFonts.katibeh(
      textStyle: const TextStyle(
        color: Colors.black,
        fontSize: 37,
      ),
    );
  }

  Future<void> _saveSelectedYears() async {
    await _prefs.setStringList('prof${email}selectedYears', _selectedYears);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Prof_Intro2()));
  }

  void _toggleYear(String year) {
    setState(() {
      if (_selectedYears.contains(year)) {
        _selectedYears.remove(year);
      } else {
        _selectedYears.add(year);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Which years do you teach in ?',
              style: _getTextStyle2(),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                _buildYearButton('F.E'),
                const SizedBox(
                  height: 25,
                ),
                _buildYearButton('S.E'),
                const SizedBox(
                  height: 25,
                ),
                _buildYearButton('T.E'),
                const SizedBox(
                  height: 25,
                ),
                _buildYearButton('B.E'),
              ],
            ),
            SizedBox(height: 65,),
            SizedBox(
              height: 65,
              width: 220,
              child: ElevatedButton(
                onPressed: _saveSelectedYears,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black
                ),
                child: Text('Save and Proceed', style: TextStyle(fontSize: 16),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearButton(String year) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () => _toggleYear(year),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
            foregroundColor:
                _selectedYears.contains(year) ? Colors.white : Colors.black,
            backgroundColor: _selectedYears.contains(year)
                ? Color.fromARGB(255, 31, 1, 61)
                : Color.fromARGB(255, 132, 188, 234),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(year)),
    );
  }
}
