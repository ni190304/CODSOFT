import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:university/professor/main/years/prof_by.dart';
import 'package:university/professor/main/years/prof_fy.dart';
import 'package:university/professor/main/years/prof_sy.dart';
import 'package:university/professor/main/years/prof_ty.dart';

class Prof_Home extends StatefulWidget {
  Prof_Home(
      {super.key,
      this.selectedYears,
      this.selectedBranches,
      this.selectedSubjects});

  List<String>? selectedYears;
  List<String>? selectedBranches;
  String? selectedSubjects;

  @override
  State<Prof_Home> createState() => _Prof_HomeState();
}

PageController _pageController = PageController();
int currentIndex = 0;
List<Widget> yearscreens = [];
Map<String, List<String>> firstYear = {};
Map<String, List<String>> secondYear = {};
Map<String, List<String>> thirdYear = {};
Map<String, List<String>> fourthYear = {};

class _Prof_HomeState extends State<Prof_Home> {
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    final decodeddata =
        (widget.selectedSubjects != null && widget.selectedSubjects!.isNotEmpty)
            ? json.decode(widget.selectedSubjects!)
            : <String, dynamic>{};

    print(decodeddata);

    for (var data in decodeddata.entries) {
      print(data.key);
      print(data.value);
      final parts = data.key.split('.');
      final year = parts.take(2).join('.');
      final _class = parts.skip(2).first;
      print(year);
      print(_class);
      if (year == 'F.E') {
        setState(() {
          firstYear.addAll({data.key: (data.value as List).cast<String>()});
        });
        if (!yearscreens.any((element) => element is Prof_First_Year)) {
          yearscreens.add(Prof_First_Year(
            fyclasses_subj: firstYear,
          ));
        }
      }

      if (year == 'S.E') {
        setState(() {
          secondYear.addAll({data.key: (data.value as List).cast<String>()});
        });
        if (!yearscreens.any((element) => element is Prof_Second_Year)) {
          yearscreens.add(Prof_Second_Year(
            syclasses_subj: secondYear,
          ));
        }
      }

      if (year == 'T.E') {
        setState(() {
          thirdYear.addAll({data.key: (data.value as List).cast<String>()});
        });
        if (!yearscreens.any((element) => element is Prof_Third_Year)) {
          yearscreens.add(Prof_Third_Year(
            tyclasses_subj: thirdYear,
          ));
        }
      }

      if (year == 'B.E') {
        setState(() {
          fourthYear.addAll({data.key: (data.value as List).cast<String>()});
        });
        if (!yearscreens.any((element) => element is Prof_Fourth_Year)) {
          yearscreens.add(Prof_Fourth_Year(
            byclasses_subj: fourthYear,
          ));
        }
      }
    }
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GNav(
                backgroundColor: Colors.white,
                selectedIndex: currentIndex,
                color: Colors.black,
                activeColor: Colors.black ,
                tabBackgroundColor: Theme.of(context).colorScheme.primary,
                onTabChange: _onTabTapped,
                gap: yearscreens.length == 4
                    ? 4
                    : yearscreens.length == 3
                        ? 5
                        : yearscreens.length == 2
                            ? 7
                            : 10,
                padding: const EdgeInsets.all(12),
                tabs: [
                  if (yearscreens.any((element) => element is Prof_First_Year))
                    const GButton(
                      text: 'First Year',
                      icon: Icons.star,
                    ),
                  if (yearscreens.any((element) => element is Prof_Second_Year))
                    const GButton(
                      text: 'Second Year',
                      icon: Icons.lightbulb_outline,
                    ),
                  if (yearscreens.any((element) => element is Prof_Third_Year))
                    const GButton(
                      text: 'Third Year',
                      icon: Icons.explore,
                    ),
                  if (yearscreens.any((element) => element is Prof_Fourth_Year))
                    const GButton(
                      text: 'Fourth Year',
                      icon: Icons.school,
                    ),
                ],
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: yearscreens,
              onPageChanged: (index) {
                setState(() {
                  currentIndex =
                      index; // Update currentIndex when PageView page changes
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
