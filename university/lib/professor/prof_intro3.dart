import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/prof_intro4.dart';

import '../details.dart';

class Prof_Intro3 extends StatefulWidget {
  const Prof_Intro3({super.key});

  @override
  State<Prof_Intro3> createState() => _Prof_Intro3State();
}

class _Prof_Intro3State extends State<Prof_Intro3> {
  late SharedPreferences _prefs;
  List<String> _selectedBranches = [];
  List<String> _selectedYears = [];
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    _getProfYears(email!);
    _getProfBranches(email!);
  }

  Future<void> _getProfYears(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedYears =
          _prefs.getStringList('prof${user_email}selectedYears') ?? [];
    });
  }

  Future<void> _getProfBranches(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedBranches =
          _prefs.getStringList('prof${user_email}selectedBranches') ?? [];
    });
  }

  List<String> _selectedClasses = [];

  void _toggleClass(String _class) {
    setState(() {
      if (_selectedClasses.contains(_class)) {
        _selectedClasses.remove(_class);
      } else {
        _selectedClasses.add(_class);
      }
    });
  }

  void _saveAndProceed() async {
    
    _prefs.setStringList('prof${email}selectedClasses', _selectedClasses);

    // Navigate to the next page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const Prof_Intro4()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Which classes are you teaching?'),
          const SizedBox(height: 20),
          Expanded(
            child: ClassesList(
              profYears: _selectedYears,
              profBranches: _selectedBranches,
              onSave: _toggleClass,
              selectedClasses: _selectedClasses,
            ),
          ),
          ElevatedButton(
            onPressed: _saveAndProceed,
            child: Text('Save and Proceed'),
          ),
        ],
      ),
    );
  }
}

class ClassesList extends StatelessWidget {
  final List<String> profYears;
  final List<String> profBranches;
  final Function(String) onSave;
  final List<String> selectedClasses;

  ClassesList({
    required this.profYears,
    required this.profBranches,
    required this.onSave,
    required this.selectedClasses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: profYears.length * profBranches.length,
      itemBuilder: (BuildContext context, int index) {
        final yearIndex = index ~/ profBranches.length;
        final branchIndex = index % profBranches.length;

        final yearData = classinfo.firstWhere(
          (year) => year['year'] == profYears[yearIndex],
          orElse: () => {},
        );

        final branchData = yearData['branches'].firstWhere(
          (branch) => branch['branch'] == profBranches[branchIndex],
          orElse: () => {},
        );

        final List<String> classes = branchData['classes'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Year: ${profYears[yearIndex]}, Branch: ${profBranches[branchIndex]}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                final _class = classes[index];
                final isSelected = selectedClasses.contains(_class);

                return GestureDetector(
                  onTap: () => onSave(_class),
                  child: Container(
                    height: 40,
                    width: 80,
                    color: isSelected ? Colors.blue : null,
                    child: Center(child: Text(_class)),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
