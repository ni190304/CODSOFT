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

  List<String> selectedSubjects = [];

  void _toggleSubject(String subject) {
    setState(() {
      if (selectedSubjects.contains(subject)) {
        selectedSubjects.remove(subject);
      } else {
        selectedSubjects.add(subject);
      }
    });
  }

  void _saveAndProceed() async {
    // Save selected subjects to SharedPreferences or any other storage method
    _prefs.setStringList('prof${email}selectedSubjects', selectedSubjects);

    // Navigate to the next page
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Prof_Intro4()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          const Text('Which subjects are you teaching?'),
          const SizedBox(height: 20),
          Expanded(
            child: ClassesList(
              profYears: _selectedYears,
              profBranches: _selectedBranches,
              onSave: _toggleSubject,
              selectedSubjects: selectedSubjects,
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
  final List<String> selectedSubjects;

  ClassesList({
    required this.profYears,
    required this.profBranches,
    required this.onSave,
    required this.selectedSubjects,
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

        final List<String> subjects = branchData['subjects'];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Year: ${profYears[yearIndex]}, Branch: ${profBranches[branchIndex]}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: subjects.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                final subject = subjects[index];
                final isSelected = selectedSubjects.contains(subject);

                return GestureDetector(
                  onTap: () => onSave(subject),
                  child: Container(
                    height: 40,
                    width: 80,
                    color: isSelected ? Colors.blue : null,
                    child: Center(child: Text(subject)),
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
