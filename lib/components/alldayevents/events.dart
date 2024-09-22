import 'package:flutter/material.dart';

import '../../types/event.types.dart';
import 'event_tile.dart';

/// Displays the all day events for a specific date.
/// params [Event] events The events to display.
/// params [DateTime] date The date to display.
class AllDayEvents extends StatelessWidget {
  final List<Event> events;
  final DateTime date;
  final bool dailyEventsExpanded;
  const AllDayEvents({
    super.key,
    required this.events,
    required this.date,
    required this.dailyEventsExpanded,
  });

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

    if (eventTiles.isEmpty) return Container();

    if (eventTiles.length > 2 && !dailyEventsExpanded) {
      eventTiles = eventTiles.sublist(0, 2);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...eventTiles,
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '+${currentEvents.length - 2}',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }

    if (dailyEventsExpanded) {
      return ListView(
        shrinkWrap: true,
        children: eventTiles,
      );
    }

    return Column(children: eventTiles);
  }
}
