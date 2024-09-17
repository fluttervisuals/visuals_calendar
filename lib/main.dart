import 'package:flutter/material.dart';

import 'mock_events.dart';
import 'types/calendar_format.types.dart';
import 'visuals_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visuals Calendar',
      home: VisualsApp(),
    );
  }
}

class VisualsApp extends StatelessWidget {
  const VisualsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VisualsCalendar(
        events: getMockEvents(),
        calendarFormat: CalendarFormat.week,
      ),
    );
  }
}
