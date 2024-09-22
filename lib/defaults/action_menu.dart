// Get the actions for the app bar.
import 'package:flutter/material.dart';

import '../types/calendar_format.types.dart';

List<Widget> getActions(
    Function() setToday, Function(CalendarFormat) setFormat) {
  return [
    IconButton(
      icon: const Icon(Icons.today),
      onPressed: setToday,
    ),
    PopupMenuButton<CalendarFormat>(
      onSelected: setFormat,
      itemBuilder: (context) {
        return [
          const PopupMenuItem(
            value: CalendarFormat.day,
            child: Text('Day'),
          ),
          const PopupMenuItem(
            value: CalendarFormat.threeDays,
            child: Text('3 Days'),
          ),
          const PopupMenuItem(
            value: CalendarFormat.week,
            child: Text('Week'),
          ),
        ];
      },
    ),
  ];
}
