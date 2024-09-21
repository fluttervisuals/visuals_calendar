import 'package:flutter/material.dart';

import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import 'event_canvas.dart';
import 'hours.dart';

/// The section of the calendar that displays the events.
/// params [calendarFormat] The calendar format. [day, week]
/// params [dates] The dates to display.
class CalendarSection extends StatefulWidget {
  // The events.
  final List<Event> events;
  // The calendar format. [day, week]
  final CalendarFormat calendarFormat;
  // The dates to display.
  final List<DateTime> dates;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const CalendarSection({
    super.key,
    required this.events,
    required this.calendarFormat,
    required this.dates,
    this.eventBuilder,
  });

  @override
  State<StatefulWidget> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  // Initialize the events
  late List<Event> events;
  // Initialize the dates
  late List<DateTime> dates;
  // Initialize the calendar format
  late CalendarFormat calendarFormat;
  // Initialize the scroll controller
  final ScrollController _scrollController = ScrollController();
  // Initialize the scroll base, used for directional scaling.
  double _scrollBase = 450;
  // Initialize the container height, used for directional scaling.
  double _containerHeight = 2400;
  // Initialize the base height, used for directional scaling.
  double _baseHeight = 100.0;
  // Initialize the vertical scale, used for directional scaling.
  double _verticalScale = 1.0;

  // Initialize the calendar state.
  @override
  void initState() {
    super.initState();
    // Set the events.
    events = widget.events;
    // Set the dates.
    dates = widget.dates;
    // Set the calendar format.
    calendarFormat = widget.calendarFormat;
    // Jump to the 450th position in the scroll controller.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollBase);
    });
  }

  // Update the container size based on the vertical scale from pinch zoom.
  void _updateContainerSize(double verticalScale) {
    // Jump to the new position based on the vertical scale.
    _scrollController
        .jumpTo(_scrollBase + (_baseHeight / 2) * (verticalScale - 1));

    // Calculate the new height based on the vertical scale.
    final newHeight = _baseHeight * verticalScale;

    setState(() {
      // Set the new vertical scale.
      _verticalScale = verticalScale;

      if (newHeight < 1200) {
        // Set the min height to 800 px.
        _containerHeight = 1200;
        return;
      }
      if (newHeight > 4800) {
        // Set the max height to 3000 px.
        _containerHeight = 4800;
        return;
      }
      _containerHeight = newHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    dates = widget.dates;
    calendarFormat = widget.calendarFormat;
    events = widget.events;
    return SingleChildScrollView(
      controller: _scrollController,
      child: GestureDetector(
        onScaleUpdate: (ScaleUpdateDetails details) {
          _updateContainerSize(details.verticalScale);
        },
        onScaleStart: (ScaleStartDetails details) {
          _baseHeight = _containerHeight;
          _scrollBase = _scrollController.position.pixels;
        },
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: _containerHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const HourColumn(),
              Expanded(
                child: EventCanvas(
                  events: events,
                  dates: dates,
                  verticalScale: _verticalScale,
                  calendarFormat: calendarFormat,
                  containerHeight: _containerHeight,
                  eventBuilder: widget.eventBuilder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
