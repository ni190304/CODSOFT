import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student_Screen extends StatefulWidget {
  const Student_Screen({super.key});

  @override
  State<Student_Screen> createState() => _Student_ScreenState();
}

class _Student_ScreenState extends State<Student_Screen> {
  late SharedPreferences _prefs;
  late String _selectedYear;
  late String _selectedBranch;
  late String _selectedClass;
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    _getStudentYear(email!);
    _getStudentBranch(email!);
    _getStudentClass(email!);
  }

  Future<void> _getStudentYear(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedYear =
          _prefs.getString('student${user_email}selectedYear') ?? '';
    });
  }

  Future<void> _getStudentBranch(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedBranch =
          _prefs.getString('student${user_email}selectedBranch') ?? '';
    });
  }

  Future<void> _getStudentClass(String user_email) async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedClass = _prefs.getString('student${email}selectedClass') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Hello student'),
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      )),
    );
  }
}
