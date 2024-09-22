import 'package:flutter/material.dart';

import '../../functions/focused_day.dart';
import '../../functions/header_height.dart';
import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import '../datesection/date_tile.dart';
import '../alldayevents/events.dart';
import 'event_canvas.dart';

class CalendarSection extends StatefulWidget {
  final List<Event> events;
  final CalendarFormat calendarFormat;
  final ScrollController mainController;
  final Function(ScaleUpdateDetails) onScaleUpdate;
  final Function(ScaleStartDetails) onScaleStart;
  final double height;
  final PageController pageController;
  final Function(int) onPageChanged;
  final int maxDailyEvents;
  final bool dailyEventsExpanded;
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const CalendarSection({
    super.key,
    required this.events,
    required this.calendarFormat,
    required this.mainController,
    required this.onScaleUpdate,
    required this.onScaleStart,
    required this.height,
    required this.pageController,
    required this.onPageChanged,
    required this.maxDailyEvents,
    required this.dailyEventsExpanded,
    this.eventBuilder,
  });

  @override
  State<StatefulWidget> createState() => CalendarSectionState();
}

class CalendarSectionState extends State<CalendarSection> {
  // Current selection for adding a new event.
  Event? selection;

  @override
  void initState() {
    super.initState();
  }

  // Set the current selection for adding a new event.
  void setSelection(Event? selection) {
    setState(() {
      this.selection = selection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: widget.pageController,
      onPageChanged: (index) => widget.onPageChanged(index),
      itemBuilder: (context, index) {
        // Get the dates to be displayed, this varies based on calendar format.
        DateTime date = getFocusedDate(index, widget.calendarFormat);

        // Initialize new controller and put in group
        final controller = ScrollController(
          initialScrollOffset: widget.mainController.offset,
        );

        // Listen to the new controller and update the main controller.
        controller.addListener(() {
          if (widget.mainController.hasClients &&
              controller.offset != widget.mainController.offset) {
            widget.mainController.jumpTo(controller.offset);
          }
        });

        // Listen to the main controller and update the new controller, but not if the change is because a change in this widget.
        widget.mainController.addListener(() {
          if (controller.hasClients &&
              widget.mainController.offset != controller.offset) {
            controller.jumpTo(widget.mainController.offset);
          }
        });

        return Column(
          children: [
            // Display the dates row.
            SizedBox(height: 60, child: DateTile(date: date)),
            // Display the all day events.
            Container(
              height: widget.dailyEventsExpanded
                  ? getExpandedHeaderHeight(widget.maxDailyEvents)
                  : getHeaderHeight(widget.maxDailyEvents),
              padding: const EdgeInsets.only(left: 4.0, top: 4.0),
              child: AllDayEvents(
                events: widget.events
                    .where((event) => event.isAllDay == true)
                    .toList(),
                date: date,
                dailyEventsExpanded: widget.dailyEventsExpanded,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            // Display the calendar section.
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: controller,
                child: GestureDetector(
                  onScaleUpdate: (ScaleUpdateDetails details) {
                    widget.onScaleUpdate(details);
                  },
                  onScaleStart: (ScaleStartDetails details) {
                    widget.onScaleStart(details);
                  },
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: widget.height,
                    child: EventCanvas(
                      events: widget.events
                          .where((event) => event.isAllDay != true)
                          .toList(),
                      date: date,
                      calendarFormat: widget.calendarFormat,
                      containerHeight: widget.height,
                      selection: selection,
                      setSelection: setSelection,
                      eventBuilder: widget.eventBuilder,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
