import 'package:flutter/material.dart';

import '../../functions/dates.dart';
import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import 'event_column.dart';

/// Displays the event columns for the current dates.
/// params list [DateTime] dates The dates to display.
/// params [double] verticalScale The vertical scale for directional scrolling.
class EventCanvas extends StatefulWidget {
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
  State<StatefulWidget> createState() => EventCanvasState();
}

class EventCanvasState extends State<EventCanvas> {
  Event? selection;

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
    List<Widget> dailycolumn = [];

    // Loop through the dates of the current view.
    for (int i = 0; i < widget.dates.length; i++) {
      // Add the selection to the events if this day.
      List<Event> addSelection =
          (selection != null && isSameDate(widget.dates[i], selection!.start))
              ? [...widget.events, selection!]
              : widget.events;

      // Add the vertical divider between dates.
      dailycolumn.add(vDivider);
      // Add the event column for the current date.
      dailycolumn.add(EventColumn(
        events: addSelection,
        date: widget.dates[i],
        verticalScale: widget.verticalScale,
        calendarFormat: widget.calendarFormat,
        containerHeight: widget.containerHeight,
        eventBuilder: widget.eventBuilder,
        selection: selection,
        setSelection: (Event? selection) =>
            setState(() => this.selection = selection),
      ));
    }

    return Row(children: dailycolumn);
  }
}
