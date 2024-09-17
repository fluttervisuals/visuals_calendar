import 'package:flutter/material.dart';

import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import '../dates_row.dart';
import 'events.dart';

/// Displays the all day events row.
/// params [Event] events The events to display.
/// params [DateTime] dates The dates to display.
class AllDayEventsRow extends StatefulWidget {
  // The events to display.
  final List<Event> events;
  // The dates to display.
  final List<DateTime> dates;
  // Calendar format
  final CalendarFormat calendarFormat;

  const AllDayEventsRow({
    super.key,
    required this.events,
    required this.dates,
    required this.calendarFormat,
  });

  @override
  State<StatefulWidget> createState() => AllDayEventsRowState();
}

class AllDayEventsRowState extends State<AllDayEventsRow> {
  late List<Event> events;
  late List<DateTime> dates;
  late CalendarFormat calendarFormat;

  @override
  void initState() {
    super.initState();
    events = widget.events;
    dates = widget.dates;
    calendarFormat = widget.calendarFormat;
  }

  @override
  Widget build(BuildContext context) {
    events = widget.events;
    dates = widget.dates;
    calendarFormat = widget.calendarFormat;
    List<Widget> dateTiles = dates.map((date) {
      return AllDayEvents(events: events, date: date);
    }).toList();

    // Container with shadow under
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          calendarFormat == CalendarFormat.day
              ? SizedBox(
                  width: 50,
                  height: 70,
                  child: DatesRow(
                    calendarFormat: calendarFormat,
                    dates: dates,
                  ),
                )
              : const SizedBox(width: 50),
          ...dateTiles
        ],
      ),
    );
  }
}
