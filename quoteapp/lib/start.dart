import '../animatedboxes/splash.dart';
import 'quote.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          seedColor: Color.fromARGB(159, 39, 2, 35),
        ),
      ),
      title: 'QuoteApp',
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.hasData && authSnapshot.data != null) {
            if (authSnapshot.connectionState == ConnectionState.waiting) {
              return const Splash();
            }

            if (authSnapshot.connectionState == ConnectionState.active) {
              if (authSnapshot.hasData) {
                return const Quote();
              } else {
                return const AuthScreen();
              }
            }

            return const Splash();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
