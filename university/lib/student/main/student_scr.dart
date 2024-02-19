import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/info/details.dart';

class Student_Screen extends StatefulWidget {
  const Student_Screen({super.key});

  @override
  State<Student_Screen> createState() => _Student_ScreenState();
}

class _Student_ScreenState extends State<Student_Screen> {
  SharedPreferences? _prefs;
  String? _selectedYear;
  String? _selectedBranch;
  String? _selectedClass;
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _prefs = prefs;
        _selectedYear = _prefs!.getString('student${email}selectedYear') ?? '';
        _selectedBranch =
            _prefs!.getString('student${email}selectedBranch') ?? '';
        _selectedClass =
            _prefs!.getString('student${email}selectedClass') ?? '';
      });
    });
  }

  late PageController _pageController;
  int currentIndex = 0;

  late List<Widget> screens;

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final yearData = classinfo.firstWhere(
      (year) => year['year'] == _selectedYear,
      orElse: () => {},
    );

    final branchData = yearData['branches']
        .firstWhere((branch) => branch['branch'] == _selectedBranch);

    final List<String> subjects = branchData['subjects'];

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          subjects[index],
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                );
              })
        ],
      )),
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
              size: 29,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 23,
            ),
            label: '',
            activeIcon: Icon(
              Icons.account_circle_outlined,
              size: 29,
            ),
          ),
        ],
      ),
    );
  }
}
