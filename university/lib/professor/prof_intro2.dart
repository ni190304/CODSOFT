import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/prof_intro2.dart';
import 'package:university/professor/prof_intro3.dart';

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
        fontSize: 30,
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
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                children: [
                  _buildBranchButton('CMPN'),
                  _buildBranchButton('IT'),
                  _buildBranchButton('MECH.'),
                  _buildBranchButton('INSTRU.'),
                  _buildBranchButton('AI&DS'),
                  _buildBranchButton('AI&ML'),
                  _buildBranchButton('EXTC'),
                  _buildBranchButton('ETRX')
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _saveSelectedBranches,
              child: Text('Save and Proceed'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchButton(String branch) {
    return ElevatedButton(
        onPressed: () => _toggleBranch(branch),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 40,
          ),
          foregroundColor:
              _selectedBranches.contains(branch) ? Colors.white : Colors.black,
          backgroundColor: _selectedBranches.contains(branch)
              ? Color.fromARGB(255, 31, 1, 61)
              : Color.fromARGB(255, 132, 188, 234),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Text(branch));
  }
}
