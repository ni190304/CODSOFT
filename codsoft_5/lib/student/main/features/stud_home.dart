import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:university/student/main/features/stud_attend.dart';
import '../../../info/details.dart';

class Stud_Home extends StatefulWidget {
  Stud_Home({
    Key? key,
    required this.selectedYear,
    required this.selectedBranch,
    required this.selectedClass,
  }) : super(key: key);

  final String? selectedYear;
  final String? selectedBranch;
  final String? selectedClass;

  @override
  State<Stud_Home> createState() => _Stud_HomeState();
}

Future<String?> getUsername(String email) async {
  final data =
      await FirebaseFirestore.instance.collection('User').doc(email).get();
  return data['username'];
}

Future<List<String>> getProfessorsWithEmail(
    String className, String subject) async {
  List<String> professorEmails = [];

  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Professor").get();

    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      if (data.containsKey("years") && data.containsKey("branches")) {
        List<String> docYears = List<String>.from(data["years"]);
        List<String> branches = List<String>.from(data["branches"]);

        if (data.containsKey("classSubjects")) {
          String classSubjects = data["classSubjects"];
          Map<String, dynamic> decodedSubjects = json.decode(classSubjects);

          if (decodedSubjects.containsKey(className)) {
            List<dynamic> subjects = decodedSubjects[className]!;
            if (subjects.contains(subject)) {
              String professorEmail = doc.id;
              professorEmails.add(professorEmail);
            }
          }
        }
      }
    });
  } catch (e) {
    print("Error fetching professors: $e");
  }

  return professorEmails;
}

class _Stud_HomeState extends State<Stud_Home> {
  Future<String?> getUserImg(String email) async {
    String imgpath = 'Professor/$email/profile/$email.jpg';

    try {
      String userDpUrl =
          await FirebaseStorage.instance.ref().child(imgpath).getDownloadURL();
      return userDpUrl;
    } catch (e) {
      print('Error loading profile image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final yearData = classinfo.firstWhere(
      (year) => year['year'] == widget.selectedYear,
      orElse: () => {},
    );

    final branchData = yearData['branches']
        .firstWhere((branch) => branch['branch'] == widget.selectedBranch);

    final List<String> subjects = branchData['subjects'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Featured Subjects for ${widget.selectedClass}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (BuildContext context, int index1) {
            final current_subject = subjects.elementAt(index1);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => Student_Attendance(subject: current_subject)));
                  },
                  child: Container(
                    height: 175,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.transparent,
                          width: 0.25,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            bottom: 80,
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, bottom: 15),
                                    child: Text(
                                      current_subject,
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned.fill(
                            top: 75,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 10),
                                        FutureBuilder(
                                          future: getProfessorsWithEmail(
                                              widget.selectedClass ?? '',
                                              current_subject),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return const CircularProgressIndicator();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else if (!snapshot.hasData ||
                                                snapshot.data!.isEmpty) {
                                              return const Text('No professors found');
                                            } else {
                                              List<String> professorEmails =
                                                  snapshot.data!;
                                              if (professorEmails.isEmpty) {
                                                return const Padding(
                                                  padding:
                                                      EdgeInsets.only(bottom: 10),
                                                  child:
                                                      Text('No professors found'),
                                                );
                                              } else {
                                                String _email =
                                                    professorEmails[0];
                                                return FutureBuilder(
                                                  future: getUsername(_email),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return Text(
                                                          'Error: ${snapshot.error}');
                                                    } else {
                                                      final username =
                                                          snapshot.data;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                bottom: 10),
                                                        child: Text(
                                                            "Professor: $username"),
                                                      );
                                                    }
                                                  },
                                                );
                                              }
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            top: 16,
                            left: 175,
                            child: Center(
                              child: FutureBuilder(
                                future: getProfessorsWithEmail(
                                    widget.selectedClass ?? '', current_subject),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('lib/pics/profile.png'),
                                      radius: 40,
                                    );
                                  } else {
                                    List<String> professorEmails = snapshot.data!;
                                    if (professorEmails.isEmpty) {
                                      return const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fpixabay.com%2Fvectors%2Fblank-profile-picture-mystery-man-973460%2F&psig=AOvVaw3GYlVPQbSsDoLaqliJYYr4&ust=1708541893754000&source=images&cd=vfe&opi=89978449&ved=0CBMQjRxqFwoTCJDrtLvMuoQDFQAAAAAdAAAAABAE',
                                        ),
                                        radius: 40,
                                      );
                                    } else {
                                      String _email = professorEmails[0];
                                      return FutureBuilder(
                                        future: getUserImg(_email),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else {
                                            final imageUrl = snapshot.data;
                                            return CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(imageUrl!),
                                              radius: 40,
                                            );
                                          }
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
