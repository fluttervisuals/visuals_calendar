import 'package:flutter/material.dart';
import 'package:visuals_calendar/types/event.types.dart';

/// Mock events for the calendar.
/// Returns a list of mock events around today's date.
List<Event> getMockEvents() {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);

  return [
    Event(
      today.add(const Duration(hours: 10)),
      'Meeting',
      Colors.blue,
      end: today.add(const Duration(hours: 12)),
    ),
    Event(
      today.add(const Duration(hours: 14)),
      'Lunch',
      Colors.green,
      end: today.add(const Duration(hours: 15)),
    ),
    Event(
      today.add(const Duration(hours: 18)),
      'Dinner',
      Colors.red,
      end: today.add(const Duration(hours: 19)),
    ),
  ];
}
