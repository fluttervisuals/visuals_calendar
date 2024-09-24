import 'package:flutter/material.dart';
import 'package:flutter_visuals/functions/events.dart';

import '../../functions/calendar_organizer.dart';
import '../../functions/dates.dart';
import '../../theme.dart';
import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import 'current_time_marker.dart';
import 'event_tile.dart';

/// A column of events for a specific date.
/// params [date] The date of the events.
/// params [events] The events to display.
/// params [verticalScale] The vertical scale for directional scrolling.
/// params [calendarFormat] The calendar format. [day, week]
class EventColumn extends StatefulWidget {
  // The events.
  final List<Event> events;
  // The date of the events.
  final DateTime date;
  // Calendar Format
  final CalendarFormat calendarFormat;
  // Container height
  final double containerHeight;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;
  // The current selection for adding a new event.
  final Event? selection;
  // Set the selection for adding a new event.
  final void Function(Event? selection) setSelection;
  // Enable selection for creating a new event.
  final bool selectionEnabled;
  // The background color.
  final Color? backgroundColor;
  // Function to call when a selection is made.
  final void Function()? saveSelection;
  // Calendar Style
  final CalendarStyle? style;

  const EventColumn({
    super.key,
    required this.events,
    required this.date,
    required this.calendarFormat,
    required this.containerHeight,
    required this.setSelection,
    required this.selectionEnabled,
    this.saveSelection,
    this.eventBuilder,
    this.selection,
    this.backgroundColor,
    this.style,
  });

  @override
  State<StatefulWidget> createState() => EventColumnState();
}

class EventColumnState extends State<EventColumn> {
  // These state variables are used for managing the state of a new event selection.
  DateTime? initial;
  DateTime? current;

  @override
  Widget build(BuildContext context) {
    List<Event> currentEvents = filterEventsByDay(widget.events, widget.date);

    List<Event> addSelection = (widget.selection != null &&
            isSameDate(widget.date, widget.selection!.start))
        ? [...currentEvents, widget.selection!]
        : currentEvents;

    int days = calendarFormatInts[widget.calendarFormat] ?? 1;
    final colWidth = (MediaQuery.of(context).size.width - 50) / days - 2;
    final hourHeight = widget.containerHeight / 24;

    final grid = getCalendarGrid(addSelection);
    List<Positioned> eventTiles = [];

    void setSelectionStart(details) => setState(() {
          initial = getDateTimeFromOffset(
            details.localPosition.dy,
            hourHeight,
            widget.date,
          );
          current = initial;
        });

    void setNewSelection(details) => setState(() {
          current = getDateTimeFromOffset(
            details.localPosition.dy,
            hourHeight,
            widget.date,
          );
          if (current == null || initial == null) return;

          final start = initial!.isBefore(current!) ? initial! : current!;
          final end = initial!.isBefore(current!) ? current! : initial!;

          if (start.difference(end).inMinutes < 30) {
            end.add(const Duration(minutes: 30));
          }

          widget.setSelection(Event(
            start,
            selectionID,
            Colors.blue,
            end: end,
          ));
        });

    for (int i = 0; i < grid.length; i++) {
      // Get the current row of the grid.
      final row = grid[i];
      // Iterate each row horizontally.
      for (int j = 0; j < row.length; j++) {
        // Get the current event in the grid.
        final event = grid[i][j];
        // Add the event tile to the list.
        if (event != null) {
          // Calculate the position and size of the event tile.
          double? left = (colWidth / row.length) * j;
          double? top =
              (event.start.hour + event.start.minute / 60) * hourHeight + 8;
          double? width = colWidth / row.length - row.length * 1;
          double? height =
              event.end!.difference(event.start).inMinutes / 60 * hourHeight -
                  2;

          eventTiles.add(
            Positioned(
              left: left,
              top: top,
              width: width,
              height: height,
              child: EventTile(
                  event: event,
                  eventBuilder: widget.eventBuilder,
                  style: widget.style),
            ),
          );
        }
      }
    }

    return GestureDetector(
      onLongPressDown: widget.selectionEnabled ? setSelectionStart : null,
      onLongPressMoveUpdate: widget.selectionEnabled ? setNewSelection : null,
      onLongPressEnd: (details) => {
        (widget.selectionEnabled && widget.saveSelection != null)
            ? widget.saveSelection!()
            : null,
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalDivider(thickness: 0.2, width: 1),
          Expanded(
            child: Container(
              // Workaround for the GestureDetector to detect content outside of widgets.
              color: widget.backgroundColor ??
                  Theme.of(context).scaffoldBackgroundColor,
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
                                thickness: 0.2,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  ...eventTiles,
                  if (isDateToday(widget.date))
                    CurrentTimeMarker(hourHeight: hourHeight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
