import 'package:flutter/material.dart';

import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import '../datesection/dates_row.dart';
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
  // Loading state
  final bool loading;

  const AllDayEventsRow({
    super.key,
    required this.events,
    required this.dates,
    required this.calendarFormat,
    required this.loading,
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

    if (widget.loading) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: SizedBox(
          height: 2,
          child: LinearProgressIndicator(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!, width: 1)),
      ),
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
