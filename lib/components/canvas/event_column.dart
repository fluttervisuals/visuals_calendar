import 'package:flutter/material.dart';

import '../../functions/calendar_organizer.dart';
import '../../functions/dates.dart';
import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import 'current_time_marker.dart';
import 'event_tile.dart';

/// A column of events for a specific date.
/// params [date] The date of the events.
/// params [events] The events to display.
/// params [verticalScale] The vertical scale for directional scrolling.
/// params [calendarFormat] The calendar format. [day, week]
class EventColumn extends StatelessWidget {
  // The events.
  final List<Event> events;
  // The date of the events.
  final DateTime date;
  // The vertical scale, used for directional scaling.
  final double verticalScale;
  // Calendar Format
  final CalendarFormat calendarFormat;
  // Container height
  final double containerHeight;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const EventColumn({
    super.key,
    required this.events,
    required this.date,
    required this.verticalScale,
    required this.calendarFormat,
    required this.containerHeight,
    this.eventBuilder,
  });

  // Filter the events for the current date.
  List<Event> getCurrentEvents() {
    return events.where((event) {
      return event.start.day == date.day &&
          event.start.month == date.month &&
          event.start.year == date.year;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Event> currentEvents = getCurrentEvents();

    int days = calendarFormatInts[calendarFormat] ?? 1;
    final colWidth = (MediaQuery.of(context).size.width - 50) / days - 2;
    final hourHeight = containerHeight / 24;

    final grid = getCalendarGrid(currentEvents);
    List<Positioned> eventTiles = [];

    for (int i = 0; i < grid.length; i++) {
      // Get the current row of the grid.
      final row = grid[i];
      // Iterate each row horizontally.
      for (int j = 0; j < row.length; j++) {
        // Get the current event in the grid.
        final event = grid[i][j];
        // Add the event tile to the list.
        if (event != null) {
          eventTiles.add(
            Positioned(
              left: (colWidth / row.length) * j,
              top:
                  (event.start.hour + event.start.minute / 60) * hourHeight + 8,
              width: colWidth / row.length - row.length * 1,
              height: event.end!.difference(event.start).inMinutes /
                      60 *
                      hourHeight -
                  2,
              child: EventTile(
                event: event,
                eventBuilder: eventBuilder,
              ),
            ),
          );
        }
      }
    }

    return Expanded(
      child: Stack(
        children: [
          Positioned(
            child: Column(
              children: [
                for (int i = 0; i < 24; i++)
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: const Divider(
                        color: Colors.grey,
                        thickness: 0.2,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          ...eventTiles,
          if (isDateToday(date)) CurrentTimeMarker(hourHeight: hourHeight),
        ],
      ),
    );
  }
}
