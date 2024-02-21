import 'package:flutter/material.dart';
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
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime(DateTime.now().year, 1, 1);
  DateTime _lastDay = DateTime(DateTime.now().year, 12, 31);
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = day;
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
                    focusedDay: _focusedDay,
                    lastDay: today,
                    headerStyle: const HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                    onDaySelected: _onDaySelected,
                    availableGestures: AvailableGestures.all,
                    calendarFormat: _calendarFormat,
                    rangeSelectionMode: _rangeSelectionMode,
                    onPageChanged: (focusedDay) {
                      setState(() {
                        _focusedDay = focusedDay;
                      });
                    },
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      selectedDecoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueGrey,
                      ),
                      todayTextStyle: const TextStyle(color: Colors.white),
                      selectedTextStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 250,
                height: 75,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shadowColor: const Color.fromARGB(255, 171, 233, 173),
                      elevation: 10,
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.assignment_turned_in_sharp,
                      size: 26,
                      color: Color.fromARGB(255, 4, 39, 5),
                    ),
                    label: Text(
                      'Mark attendance',
                      style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontSize: 23),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
