import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/intro/prof_intro2.dart';
import 'package:university/professor/intro/prof_intro3.dart';

class Prof_Intro2 extends StatefulWidget {
  const Prof_Intro2({Key? key}) : super(key: key);

  @override
  State<Prof_Intro2> createState() => _Prof_Intro2State();
}

class _Prof_Intro2State extends State<Prof_Intro2> {
  late SharedPreferences _prefs;
  List<String> _selectedBranches = [];
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

  Future<void> _saveSelectedBranches() async {
    await _prefs.setStringList(
        'prof${email}selectedBranches', _selectedBranches);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Prof_Intro3()));
  }

  void _toggleBranch(String branch) {
    setState(() {
      if (_selectedBranches.contains(branch)) {
        _selectedBranches.remove(branch);
      } else {
        _selectedBranches.add(branch);
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
              'Which branchs do you teach in ?',
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
            SizedBox(
              height:65,
            ),
            SizedBox(
              height: 65,
              width: 220,
              child: ElevatedButton(
                onPressed: _saveSelectedBranches,
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

  Widget _buildBranchButton(String branch) {
    return SizedBox(
      height: 50,
      width: 150,
      child: ElevatedButton(
          onPressed: () => _toggleBranch(branch),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 40,
            ),
            foregroundColor: _selectedBranches.contains(branch)
                ? Colors.white
                : Colors.black,
            backgroundColor: _selectedBranches.contains(branch)
                ? Color.fromARGB(255, 31, 1, 61)
                : Color.fromARGB(255, 132, 188, 234),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          child: Text(branch)),
    );
  }
}
