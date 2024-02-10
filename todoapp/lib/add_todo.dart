import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formatter = DateFormat.yMd();

final email = FirebaseAuth.instance.currentUser!.email;

late int _index;

class Add_Todo extends StatefulWidget {
  const Add_Todo({super.key});

  @override
  State<Add_Todo> createState() => _Add_TodoState();
}

class TaskIndexNotifier extends ChangeNotifier {
  int get index => _index;

  Future<void> increment() async {
    _index++;
    notifyListeners();
    await _saveIndexToPrefs();
  }

  // Load index from shared preferences during initialization
  Future<void> loadIndexFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _index = prefs.getInt('${email}PendingTaskIndex') ?? 1;
    notifyListeners();
  }

  // Save index to shared preferences
  Future<void> _saveIndexToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('${email}PendingTaskIndex', _index);
  }
}

class _Add_TodoState extends State<Add_Todo> {
  final _titlecontroller = TextEditingController();
  final _descontroller = TextEditingController();
  DateTime? due;
  bool isFav = false;
  bool isComp = false;

  @override
  void initState() {
    super.initState();
    final email = FirebaseAuth.instance.currentUser!.email;
  }

  void _presentDatePicker() async {
    try {
      final now = DateTime.now();
      final firstDate = DateTime(now.year, now.month, now.day);
      final lastDate = DateTime(now.year + 1, now.month, now.day);

      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
      );

      if (pickedDate != null) {
        // ignore: use_build_context_synchronously
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(now),
        );

        if (pickedTime != null) {
          DateTime selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (selectedDateTime.isAfter(now)) {
            setState(() {
              due = selectedDateTime;
            });
          } else {
            // Show an error message or handle the invalid selection
            // ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Invalid Time Selection'),
                content: const Text('Please select a time in the future.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void submitData() async {
    final taskIndexNotifier =
        Provider.of<TaskIndexNotifier>(context, listen: false);

    final currentId = taskIndexNotifier.index;

    String uuid = Uuid().v4();

    final email = FirebaseAuth.instance.currentUser!.email;

    if (_titlecontroller.text.isEmpty ||
        _descontroller.text.isEmpty ||
        due == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please make sure to enter all fields'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Icon(Icons.thumb_up_sharp),
            )
          ],
        ),
      );

      return;
    }

    await FirebaseFirestore.instance
        .collection("Tasks")
        .doc(email)
        .collection("`Pending%20Tasks`")
        .doc("Task ${taskIndexNotifier.index}")
        .set({
      "id": uuid,
      "title": _titlecontroller.text,
      "description": _descontroller.text,
      "due": due,
      "creation": DateTime.now(),
      "isFav": isFav,
      'isComp': isComp
    });

    taskIndexNotifier.increment();

    Navigator.pop(context);
  }

  void dispose1() {
    _titlecontroller.dispose();
    _descontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextFormField(
                  controller: _titlecontroller,
                  maxLength: 10,
                  decoration: const InputDecoration(
                    labelText: 'Task',
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _descontroller,
                        maxLength: 20,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(due == null
                              ? 'No date selected'
                              : formatter.format(due!)),
                          IconButton(
                              onPressed: () {
                                _presentDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month)),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    ElevatedButton(
                        onPressed: () {
                          submitData();
                        },
                        child: const Text('Save Task'))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
