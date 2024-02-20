import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/main/features/prof_home.dart';
import 'package:university/professor/main/features/prof_profile.dart';

import 'features/stud_home.dart';
import 'features/stud_profile.dart';

class Student_Screen extends StatefulWidget {
  const Student_Screen({Key? key}) : super(key: key);

  @override
  State<Student_Screen> createState() => _Student_ScreenState();
}

class _Student_ScreenState extends State<Student_Screen> {
  SharedPreferences? _prefs;
  String? _selectedYear;
  String? _selectedBranch;
  String? _selectedClass;
  String? email;

  late PageController _pageController;
  int currentIndex = 0;
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    _pageController = PageController();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _selectedYear =
            _prefs!.getString('student${email}selectedYear') ?? '';
        _selectedBranch =
            _prefs!.getString('student${email}selectedBranch') ?? '';
        _selectedClass =
            _prefs!.getString('student${email}selectedClass') ?? '';
        _initScreens();
      });
    });
  }

  void _initScreens() {
    screens = [
      Stud_Home(selectedYear: _selectedYear,selectedBranch: _selectedBranch, selectedClass: _selectedClass),
      const Stud_Profile(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout_outlined)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(
            color: Color.fromARGB(255, 227, 223, 223),
            thickness: 0.9,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SafeArea(
                child: PageView(
                  controller: _pageController,
                  children: screens,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 23,
            ),
            label: '',
            activeIcon: Icon(
              Icons.home,
              size: 32,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              size: 23,
            ),
            label: '',
            activeIcon: Icon(
              Icons.account_circle,
              size: 32,
            ),
          ),
        ],
      ),
    );
  }
}

