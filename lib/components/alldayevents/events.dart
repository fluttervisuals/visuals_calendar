import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import 'event_tile.dart';

/// Displays the all day events for a specific date.
/// params [Event] events The events to display.
/// params [DateTime] date The date to display.
class AllDayEvents extends StatelessWidget {
  // The events to display.
  final List<Event> events;
  // The date to display.
  final DateTime date;
  // If the daily events are expanded.
  final bool dailyEventsExpanded;
  // The calendar format. [day, week]
  final CalendarFormat calendarFormat;
  // The style.
  final CalendarStyle? style;

  const AllDayEvents({
    super.key,
    required this.events,
    required this.date,
    required this.dailyEventsExpanded,
    required this.calendarFormat,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    List<Event> currentEvents = events.where((event) {
      return event.start.day == date.day &&
          event.start.month == date.month &&
          event.start.year == date.year;
    }).toList();

    List<Widget> eventTiles = currentEvents.map((event) {
      return AllDayEventTile(event: event, style: style);
    }).toList();

    int numEvents = currentEvents.length;
    int maxEvents = calendarFormat == CalendarFormat.day ? 3 : 2;

    if (eventTiles.isEmpty) return Container();

    final textStyle = style?.eventTitleTextStyle ??
        Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.bold);

    if (numEvents > maxEvents && !dailyEventsExpanded) {
      eventTiles = eventTiles.sublist(0, maxEvents);
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...eventTiles,
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '+${currentEvents.length - maxEvents}',
              style: textStyle,
            ),
          ),
        ],
      );
    }

    if (dailyEventsExpanded) {
      return ListView(
        children: eventTiles,
      );
    }

    return Column(children: eventTiles);
  }
}
