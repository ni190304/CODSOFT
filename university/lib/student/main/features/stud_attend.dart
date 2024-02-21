import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Student_Attendance extends StatefulWidget {
  Student_Attendance({super.key, required this.subject});

  String? subject;

  @override
  State<Student_Attendance> createState() => _Student_AttendanceState();
}

class _Student_AttendanceState extends State<Student_Attendance> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();
  DateTime _firstDay = DateTime(DateTime.now().year, 1, 1);
  DateTime _lastDay = DateTime(DateTime.now().year, 12, 31);
  String? email;

  @override
  void initState() {
    email = FirebaseAuth.instance.currentUser!.email;
    super.initState();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _saveDates(List<DateTime> _dates) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> dateStrings = _dates.map((date) {
      return '${date.day}/${date.month}/${date.year}';
    }).toList();

    await prefs.setStringList(
        '$email/${widget.subject}/marked_dates', dateStrings);

    print(dateStrings);
  }

  List<DateTime> _marked_dates = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                'Attendance  for ${widget.subject}',
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 0.25),
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: TableCalendar(
                    locale: "en_US",
                    firstDay: _firstDay,
                    focusedDay: today,
                    lastDay: _lastDay,
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    onDaySelected: _onDaySelected,
                    availableGestures: AvailableGestures.all,
                    calendarFormat: _calendarFormat,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 250,
                height: 60,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shadowColor: const Color.fromARGB(255, 171, 233, 173),
                      elevation: 10,
                    ),
                    onPressed: () {
                      if (isSameDay(today, DateTime.now())) {
                        _marked_dates.add(today);

                        _saveDates(_marked_dates);
                      } else {}
                    },
                    icon: const Icon(
                      Icons.assignment_turned_in_sharp,
                      size: 22,
                      color: Color.fromARGB(255, 4, 39, 5),
                    ),
                    label: Text(
                      isSameDay(today, DateTime.now())
                          ? 'Mark attendance'
                          : 'Day Missed',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 20),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
