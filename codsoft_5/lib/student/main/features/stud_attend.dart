import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:university/animatedboxes/neubox4.dart';

class Student_Attendance extends StatefulWidget {
  Student_Attendance({super.key, required this.subject});

  final String? subject;

  @override
  State<Student_Attendance> createState() => _Student_AttendanceState();
}

class _Student_AttendanceState extends State<Student_Attendance> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime today = DateTime.now();
  DateTime _firstDay = DateTime(DateTime.now().year, 1, 1);
  DateTime _lastDay = DateTime(DateTime.now().year, 12, 31);
  DateTime bb = DateTime.now();
  String? email;
  List<DateTime>? _marked_dates;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    _loadDates();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Future<void> _loadDates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? dateStrings =
        prefs.getStringList('$email/${widget.subject}/d');

    setState(() {
      _marked_dates = dateStrings?.map((dateString) {
            List<String> dateComponents = dateString.split('/');
            int day = int.parse(dateComponents[0]);
            int month = int.parse(dateComponents[1]);
            int year = int.parse(dateComponents[2]);
            return DateTime(year, month, day);
          }).toList() ??
          [];
    });

    print(_marked_dates);
  }

  Future<void> _saveDates(List<DateTime> _dates) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> dateStrings = _dates.map((date) {
      return '${date.day}/${date.month}/${date.year}';
    }).toList();
    await prefs.setStringList('$email/${widget.subject}/d', dateStrings);

    setState(() {
      _marked_dates = _dates;
    });
  }

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
                height: 17,
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
                    lastDay: bb,
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
                height: 10,
              ),
              Neubox4(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total present: ',
                      style: TextStyle(fontSize: 24, color: Colors.brown),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 75,
                      width: 1,
                      color: Colors.black,
                    ),
                    SizedBox(width: 20),
                    Text(
                      (_marked_dates != null
                          ? _marked_dates!.length.toString()
                          : '0'),
                      style: TextStyle(fontSize: 27),
                    ), // Access the data property
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shadowColor: const Color.fromARGB(255, 171, 233, 173),
                    elevation: 10,
                  ),
                  onPressed: () {
                    if (isSameDay(today, DateTime.now()) &&
                        !_marked_dates!.contains(today)) {
                      _marked_dates!.add(today);
                      _saveDates(_marked_dates!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Marked your attendance successfully !!!'),
                          duration:
                              Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.assignment_turned_in_sharp,
                    size: 22,
                    color: Color.fromARGB(255, 4, 39, 5),
                  ),
                  label: Text(
                    _marked_dates != null && !_marked_dates!.contains(today)
                        ? 'Mark attendance'
                        : _marked_dates != null &&
                                _marked_dates!.contains(today)
                            ? 'Already marked'
                            : 'Day Missed',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
