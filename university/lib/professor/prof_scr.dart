import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Professor_Screen extends StatefulWidget {
  const Professor_Screen({super.key});

  @override
  State<Professor_Screen> createState() => _Professor_ScreenState();
}

class _Professor_ScreenState extends State<Professor_Screen> {
  late SharedPreferences _prefs;
  List<String> _selectedBranches = [];
  List<String> _selectedYears = [];
  List<String> _selectedSubjects = [];
  List<String> _selectedClasses = [];
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    _getProfYears(email!);
    _getProfBranches(email!);
    _getProfSubjects(email!);
    _getProfClasses(email!);
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

  Future<void> _getProfSubjects(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSubjects =
          _prefs.getStringList('prof${user_email}selectedSubjects') ?? [];
    });
  }

  Future<void> _getProfClasses(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedClasses =
          _prefs.getStringList('prof${user_email}selectedClasses') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Hello professor'),
      ),
    );
  }
}
