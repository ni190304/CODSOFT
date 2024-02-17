import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:university/animatedboxes/splash.dart';
import 'package:university/auth.dart';
import 'package:university/professor/prof_intro1.dart';
import 'package:university/professor/prof_scr.dart';
import 'package:university/student/stud_intro1.dart';
import 'package:university/student/student_scr.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    final email = FirebaseAuth.instance.currentUser!.email;
    isProfessor(email!);
    super.initState();
  }

  bool? isProf;

  Future<void> isProfessor(String user_email) async {
    final status = await FirebaseFirestore.instance
        .collection('User')
        .doc(user_email)
        .get();

    setState(() {
      isProf = status['professor'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(159, 3, 25, 41),
        ),
      ),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, authsnapshot) {
            if (authsnapshot.hasData && authsnapshot.data != null) {
              final email = FirebaseAuth.instance.currentUser!.email;
              return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('User')
                      .doc(email)
                      .snapshots(),
                  builder: (context, usersnapshot) {
                    return StreamBuilder<
                            DocumentSnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection('Professor')
                            .doc(email)
                            .snapshots(),
                        builder: (context, profsnapshot) {
                          return StreamBuilder<
                                  DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('Student')
                                  .doc(email)
                                  .snapshots(),
                              builder: (context, studsnapshot) {
                                if (authsnapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    studsnapshot.connectionState ==
                                        ConnectionState.waiting ||
                                    profsnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                  return const Splash();
                                }

                                if (authsnapshot.connectionState ==
                                    ConnectionState.active) {
                                  if (authsnapshot.hasData) {
                                    if (profsnapshot.connectionState ==
                                            ConnectionState.active &&
                                        profsnapshot.hasData &&
                                        profsnapshot.data!.exists) {
                                      return const Professor_Screen();
                                    } else if (studsnapshot.connectionState ==
                                            ConnectionState.active &&
                                        studsnapshot.hasData &&
                                        studsnapshot.data!.exists) {
                                      return const Student_Screen();
                                    } else if (isProf == true) {
                                      return const Prof_Intro1();
                                    } else {
                                      return const Student_Intro1();
                                    }
                                  } else {
                                    return const AuthScreen();
                                  }
                                }

                                return const Splash();
                              });
                        });
                  });
            } else {
              return const AuthScreen();
            }
          }),
    );
  }
}
