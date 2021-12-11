import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle),
                  todayDecoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  todayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonDecoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  formatButtonTextStyle: TextStyle(color: Colors.white),
                  formatButtonShowsNext: false),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2021, 10, 16),
              lastDay: DateTime.utc(2023, 10, 16),
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  // Call `setState()` when updating calendar format
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                // No need to call `setState()` here
                _focusedDay = focusedDay;
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
              },
              calendarBuilders: CalendarBuilders(
                dowBuilder: (context, day) {
                  if (day.weekday == DateTime.sunday) {
                    final text = DateFormat.E().format(day);

                    return Center(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  }
                },
                selectedBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange, shape: BoxShape.circle),
                  child: Text(date.day.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
                todayBuilder: (context, date, events) => Container(
                  margin: const EdgeInsets.all(4.8),
                  alignment: Alignment.center,
                  decoration:
                      BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                  child: Text(date.day.toString(),
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
