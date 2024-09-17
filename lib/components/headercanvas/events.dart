import 'package:flutter/material.dart';

import '../../types/event.types.dart';
import 'event_tile.dart';

/// Displays the all day events for a specific date.
/// params [Event] events The events to display.
/// params [DateTime] date The date to display.
class AllDayEvents extends StatelessWidget {
  final List<Event> events;
  final DateTime date;
  const AllDayEvents({super.key, required this.events, required this.date});

  @override
  Widget build(BuildContext context) {
    List<Event> currentEvents = events.where((event) {
      return event.start.day == date.day &&
          event.start.month == date.month &&
          event.start.year == date.year;
    }).toList();

    List<Widget> eventTiles = currentEvents.map((event) {
      return AllDayEventTile(event: event);
    }).toList();

    return Expanded(child: Column(children: eventTiles));
  }
}
