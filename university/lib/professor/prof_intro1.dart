import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/prof_intro2.dart';

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
  }

  Future<void> _saveSelectedYears() async {
    await _prefs.setStringList('prof${email}selectedYears', _selectedYears);

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Prof_Intro2()));
    });
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
      body: Column(
        children: [
          const Text('Which years do you teach in ?'),
          const SizedBox(height: 50),
          Column(
            children: [
              _buildYearButton('F.E'),
              _buildYearButton('S.E'),
              _buildYearButton('T.E'),
              _buildYearButton('B.E'),
            ],
          ),
          ElevatedButton(
            onPressed: _saveSelectedYears,
            child: Text('Save and Proceed'),
          ),
        ],
      ),
    );
  }

  Widget _buildYearButton(String year) {
    return GestureDetector(
      onTap: () => _toggleYear(year),
      child: Container(
        height: 20,
        width: 40,
        color: _selectedYears.contains(year) ? Colors.blue : null,
        child: Center(child: Text(year)),
      ),
    );
  }
}
