import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/todo.dart';
import '../animatedboxes/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'intro.dart';
import 'auth.dart';

class Start extends StatefulWidget {
  const Start({
    Key? key,
  }) : super(key: key);

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  // bool isConnected = true;

  @override
  void initState() {
    super.initState();
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
      title: 'TodoApp',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.hasData && authSnapshot.data != null) {
            final currentEmail = authSnapshot.data!.email;
            return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .doc(currentEmail)
                  .snapshots(),
              builder: (context, userSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.waiting ||
                    userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Splash();
                }

                if (authSnapshot.connectionState == ConnectionState.active) {
                  if (authSnapshot.hasData) {
                    if (userSnapshot.connectionState ==
                            ConnectionState.active &&
                        userSnapshot.hasData &&
                        userSnapshot.data!.exists) {
                      return const Todo();
                    } else {
                      return const Intro();
                    }
                  } else {
                    return const AuthScreen();
                  }
                }

                return const Splash();
              },
            );
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}

// Future<void> isInternetConnected() async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   setState(() {
  //     isConnected = (connectivityResult == ConnectivityResult.mobile ||
  //         connectivityResult == ConnectivityResult.wifi);
  //   });
  // }
