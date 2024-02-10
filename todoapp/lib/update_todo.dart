import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formatter = DateFormat.yMd();

final email = FirebaseAuth.instance.currentUser!.email;

late int _index;

class Update_Todo extends StatefulWidget {
  const Update_Todo({super.key, required this.task});

  final Map<String, dynamic> task;

  @override
  State<Update_Todo> createState() => _Update_TodoState();
}

class _Update_TodoState extends State<Update_Todo> {
  late TextEditingController _titlecontroller;
  late TextEditingController _descontroller;
  late DateTime _dueDate;
  late String _id;

  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(text: widget.task['title']);
    _descontroller = TextEditingController(text: widget.task['description']);
    _dueDate = (widget.task['due'] as Timestamp).toDate();
    _id = widget.task['id'];
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
              _dueDate = selectedDateTime;
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
    final email = FirebaseAuth.instance.currentUser!.email;

    String title = _titlecontroller.text;
    String description = _descontroller.text;

    if (_titlecontroller.text.isEmpty || _descontroller.text.isEmpty) {
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

    try {
      await FirebaseFirestore.instance
          .collection("Tasks")
          .doc(email)
          .collection("`Pending%20Tasks`")
          .where('id', isEqualTo: _id)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.update({
            'title': title,
            'description': description,
            'due': _dueDate,
            'creation': DateTime.now(),
          });
        });
      });

      Navigator.pop(context);
    } catch (e) {
      print('Error updating task: $e');
    }
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
                          Text(_dueDate == null
                              ? 'No date selected'
                              : formatter.format(_dueDate)),
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
