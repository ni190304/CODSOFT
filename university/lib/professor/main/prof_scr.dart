import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university/professor/main/features/prof_home.dart';
import 'package:university/professor/main/features/prof_profile.dart';

class Professor_Screen extends StatefulWidget {
  const Professor_Screen({Key? key}) : super(key: key);

  @override
  State<Professor_Screen> createState() => _Professor_ScreenState();
}

class _Professor_ScreenState extends State<Professor_Screen> {
  SharedPreferences? _prefs;
  List<String>? _selectedBranches;
  List<String>? _selectedYears;
  String? _selectedSubjects;
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
        _selectedYears =
            _prefs!.getStringList('prof${email}selectedYears') ?? [];
        _selectedBranches =
            _prefs!.getStringList('prof${email}selectedBranches') ?? [];
        _selectedSubjects =
            _prefs!.getString('prof${email}selectedSubjects') ?? '';
        _initScreens();
      });
    });
  }

  void _initScreens() {
    screens = [
      Prof_Home(
        selectedYears: _selectedYears,
        selectedBranches: _selectedBranches,
        selectedSubjects: _selectedSubjects,
      ),
      const Prof_Profile(),
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
