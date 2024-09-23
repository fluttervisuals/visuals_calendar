import 'package:flutter/material.dart';
import 'package:visuals_calendar/types/calendar_format.types.dart';
import 'package:visuals_calendar/visuals_calendar.dart';

import 'mock_events.dart';

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
        defaultFormat: CalendarFormat.week,
      ),
    );
  }
}
