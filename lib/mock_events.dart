import 'package:flutter/material.dart';

import 'types/event.types.dart';

/// Mock events for the calendar.
/// Returns a list of mock events around today's date.
List<Event> getMockEvents() {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  DateTime tomorrow = today.add(const Duration(days: 1));
  DateTime dayAfterTomorrow = today.add(const Duration(days: 2));
  DateTime yesterday = today.subtract(const Duration(days: 1));
  DateTime dayBeforeYesterday = today.subtract(const Duration(days: 2));

  return [
    Event(
      today.add(const Duration(hours: 10)),
      today.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
      isAllDay: true,
    ),
    Event(
      today.add(const Duration(hours: 14)),
      today.add(const Duration(hours: 16)),
      'Lunch',
      Colors.green,
      isAllDay: true,
    ),
    Event(
      today.add(const Duration(hours: 14)),
      today.add(const Duration(hours: 16)),
      'Lunch',
      Colors.green,
      isAllDay: true,
    ),
    Event(
      tomorrow.add(const Duration(hours: 10)),
      tomorrow.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
      isAllDay: true,
    ),
    Event(
      today.add(const Duration(hours: 10)),
      today.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
    ),
    Event(
      today.add(const Duration(hours: 11)),
      today.add(const Duration(hours: 13)),
      'Meeting',
      Colors.blue,
    ),
    Event(
      today.add(const Duration(hours: 14)),
      today.add(const Duration(hours: 16)),
      'Lunch',
      Colors.green,
    ),
    Event(
      tomorrow.add(const Duration(hours: 10)),
      tomorrow.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
    ),
    Event(
      tomorrow.add(const Duration(hours: 14)),
      tomorrow.add(const Duration(hours: 16)),
      'Lunch',
      Colors.pink[300]!,
    ),
    Event(
      dayAfterTomorrow.add(const Duration(hours: 10)),
      dayAfterTomorrow.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
    ),
    Event(
      dayAfterTomorrow.add(const Duration(hours: 14)),
      dayAfterTomorrow.add(const Duration(hours: 16)),
      'Lunch',
      Colors.green,
      isAllDay: true,
    ),
    Event(
      yesterday.add(const Duration(hours: 10)),
      yesterday.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
    ),
    Event(
      yesterday.add(const Duration(hours: 14)),
      yesterday.add(const Duration(hours: 16)),
      'Lunch',
      Colors.green,
    ),
    Event(
      dayBeforeYesterday.add(const Duration(hours: 10)),
      dayBeforeYesterday.add(const Duration(hours: 12)),
      'Meeting',
      Colors.blue,
    ),
    Event(
      dayBeforeYesterday.add(const Duration(hours: 14)),
      dayBeforeYesterday.add(const Duration(hours: 16)),
      'Lunch',
      Colors.green,
    ),
  ];
}
