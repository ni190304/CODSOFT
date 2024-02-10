import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/add_todo.dart';
import 'package:todo/auth/start.dart';
import 'auth/firebase_options.dart';

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
        TaskIndexNotifier taskIndexNotifier = TaskIndexNotifier();
        taskIndexNotifier.loadIndexFromPrefs(); // Load index from prefs
        return taskIndexNotifier;
      },
      child: const Start()));
}
