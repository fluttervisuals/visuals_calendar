import 'package:flutter/material.dart';

import '../types/calendar_format.types.dart';
import 'date_tile.dart';

/// Displays a row of dates in the calendar.
/// params [calendarFormat] The calendar format. [day, week]
/// params [dates] The dates to display.
class DatesRow extends StatelessWidget {
  // The calendar format. [day, week]
  final CalendarFormat calendarFormat;
  // The dates to display.
  final List<DateTime> dates;

  const DatesRow({
    super.key,
    required this.calendarFormat,
    required this.dates,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> dateTiles = dates.map((date) {
      return Expanded(child: DateTile(date: date));
    }).toList();

    if (calendarFormat == CalendarFormat.day) {
      return SizedBox(width: 50, child: Row(children: [dateTiles.first]));
    }
    return Row(children: [const SizedBox(width: 50), ...dateTiles]);
  }
}
