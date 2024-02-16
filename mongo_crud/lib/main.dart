import 'package:flutter/material.dart';
import 'package:mongo_crud/dbhelper/mongodb.dart';
import 'package:mongo_crud/display.dart';
import 'package:mongo_crud/insert.dart';
import 'package:mongo_crud/update.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'MongoDB CRUD',
        theme: ThemeData(primaryColor: Colors.blue),
        home: const MongoDbUpdate());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


