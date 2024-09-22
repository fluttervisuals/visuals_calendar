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
  final DateTime date;
  // The calendar format.
  final CalendarFormat calendarFormat;
  // The container height, used for directional scaling.
  final double containerHeight;
  // Current selection for adding a new event.
  final Event? selection;
  // Set the selection for adding a new event.
  final void Function(Event? selection) setSelection;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const EventCanvas({
    super.key,
    required this.events,
    required this.date,
    required this.calendarFormat,
    required this.containerHeight,
    required this.setSelection,
    this.selection,
    this.eventBuilder,
  });

  @override
  State<StatefulWidget> createState() => EventCanvasState();
}

class EventCanvasState extends State<EventCanvas> {
  @override
  // Create event column of current dates.
  Widget build(BuildContext context) {
    // Add the selection to the events if this day.
    List<Event> addSelection = (widget.selection != null &&
            isSameDate(widget.date, widget.selection!.start))
        ? [...widget.events, widget.selection!]
        : widget.events;

    return EventColumn(
      events: addSelection,
      date: widget.date,
      calendarFormat: widget.calendarFormat,
      containerHeight: widget.containerHeight,
      eventBuilder: widget.eventBuilder,
      selection: widget.selection,
      setSelection: (Event? selection) => widget.setSelection(selection),
    );
  }
}
