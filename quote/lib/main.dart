import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quote/screens/home.dart';
import 'firebase_options.dart';
import 'auth/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ChangeNotifierProvider(
      create: (context) {
        FavIndexNotifier taskIndexNotifier = FavIndexNotifier();
        taskIndexNotifier.loadFavIndexFromPrefs(); // Load index from prefs
        return taskIndexNotifier;
      },
      child: const Start()));
}
