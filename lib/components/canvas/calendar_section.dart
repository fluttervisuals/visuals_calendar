import 'package:flutter/material.dart';

import '../../functions/focused_day.dart';
import '../../functions/header_height.dart';
import '../../theme.dart';
import '../../types/calendar_format.types.dart';
import '../../types/event.types.dart';
import '../datesection/date_tile.dart';
import '../alldayevents/events.dart';
import 'event_column.dart';

class CalendarSection extends StatefulWidget {
  final List<Event> events;
  final CalendarFormat calendarFormat;
  final ScrollController mainController;
  final Function(ScaleUpdateDetails) onScaleUpdate;
  final Function(ScaleStartDetails) onScaleStart;
  final Function(int) onPageChanged;
  final double height;
  final PageController pageController;
  final int maxDailyEvents;
  final bool dailyEventsExpanded;
  final Widget Function(BuildContext context, Event event)? eventBuilder;
  final CalendarStyle? style;
  final bool selectionEnabled;
  final void Function(DateTime start, DateTime end)? onTimeSelected;
  final bool loading;

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
    required this.loading,
    required this.selectionEnabled,
    this.onTimeSelected,
    this.eventBuilder,
    this.style,
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

  void saveSelection() {
    if (widget.onTimeSelected != null && selection != null) {
      widget.onTimeSelected!(
        selection!.start,
        selection!.end ?? selection!.start.add(const Duration(hours: 1)),
      );
    }
    setSelection(null);
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

        double dailyEventsHeight = getExpandedHeaderHeight(
          widget.maxDailyEvents,
          isExpanded: widget.dailyEventsExpanded,
        );

        double dayFormatEventsHeight = getDayFormatHeaderHeight(
          widget.maxDailyEvents,
          isExpanded: widget.dailyEventsExpanded,
        );

        double dynamicHeight = widget.calendarFormat == CalendarFormat.day
            ? dayFormatEventsHeight
            : dailyEventsHeight;

        return Column(
          children: [
            // Display the dates row if the calendar format is not day, otherwise it will be another place.
            if (widget.calendarFormat != CalendarFormat.day)
              Container(
                color: widget.style?.headerColor,
                height: 60,
                child: Row(children: [
                  Expanded(child: DateTile(date: date, style: widget.style))
                ]),
              ),
            // Display the all day events.
            Container(
              color: widget.style?.headerColor,
              height: dynamicHeight,
              padding: const EdgeInsets.only(left: 4.0, top: 4.0),
              child: Row(
                children: [
                  Expanded(
                    child: AllDayEvents(
                      events: widget.events
                          .where((event) => event.isAllDay == true)
                          .toList(),
                      date: date,
                      dailyEventsExpanded: widget.dailyEventsExpanded,
                      calendarFormat: widget.calendarFormat,
                      style: widget.style,
                    ),
                  ),
                  const VerticalDivider(
                    width: 0.1,
                    thickness: 0.2,
                  ),
                ],
              ),
            ),
            if (!widget.loading)
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
                    color: widget.style?.backgroundColor ??
                        Theme.of(context).scaffoldBackgroundColor,
                    height: widget.height,
                    child: EventColumn(
                      events: widget.events
                          .where((event) => event.isAllDay != true)
                          .toList(),
                      date: date,
                      calendarFormat: widget.calendarFormat,
                      containerHeight: widget.height,
                      selection: selection,
                      setSelection: setSelection,
                      saveSelection: saveSelection,
                      eventBuilder: widget.eventBuilder,
                      selectionEnabled: widget.selectionEnabled,
                      backgroundColor: widget.style?.backgroundColor,
                      style: widget.style,
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
