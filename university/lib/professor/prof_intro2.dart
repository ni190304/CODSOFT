import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/prof_intro2.dart';

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
  }

  Future<void> _saveSelectedBranches() async {
    await _prefs.setStringList('prof${email}selectedBranches', _selectedBranches);

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Prof_Intro2()));
    });
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
      body: Column(
        children: [
          const Text('Which branchs do you teach in ?'),
          const SizedBox(height: 50),
          GridView(
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
          ElevatedButton(
            onPressed: _saveSelectedBranches,
            child: Text('Save and Proceed'),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchButton(String branch) {
    return GestureDetector(
      onTap: () => _toggleBranch(branch),
      child: Container(
        height: 20,
        width: 40,
        color: _selectedBranches.contains(branch) ? Colors.blue : null,
        child: Center(child: Text(branch)),
      ),
    );
  }
}
