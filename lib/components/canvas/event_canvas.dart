import 'package:flutter/material.dart';

import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import 'event_column.dart';

/// Displays the event columns for the current dates.
/// params list [DateTime] dates The dates to display.
/// params [double] verticalScale The vertical scale for directional scrolling.
class EventCanvas extends StatelessWidget {
  // The events
  final List<Event> events;
  // The dates to display.
  final List<DateTime> dates;
  // The vertical scale, used for directional scaling.
  final double verticalScale;
  // The calendar format.
  final CalendarFormat calendarFormat;
  // The container height, used for directional scaling.
  final double containerHeight;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const EventCanvas({
    super.key,
    required this.events,
    required this.dates,
    required this.verticalScale,
    required this.calendarFormat,
    required this.containerHeight,
    this.eventBuilder,
  });

  @override
  // Create event column of current dates.
  Widget build(BuildContext context) {
    // Initialize the vertical divider.
    const vDivider = VerticalDivider(
      color: Colors.grey,
      thickness: 0.2,
      width: 0,
    );

    // Initialize the event columns of the current displayed dates.
    List<Widget> dateTiles = [];

    // Loop through the dates of the current view.
    for (int i = 0; i < dates.length; i++) {
      // Add the vertical divider between dates.
      dateTiles.add(vDivider);
      // Add the event column for the current date.
      dateTiles.add(EventColumn(
        events: events,
        date: dates[i],
        verticalScale: verticalScale,
        calendarFormat: calendarFormat,
        containerHeight: containerHeight,
        eventBuilder: eventBuilder,
      ));
    }

    return Row(children: dateTiles);
  }
}
