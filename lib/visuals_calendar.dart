library visuals_calendar;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/canvas/calendar_section.dart';
import 'components/dates_row.dart';
import 'components/headercanvas/events_row.dart';
import 'functions/dates.dart';
import 'types/calendar_format.types.dart';
import 'types/event.types.dart';

/// A Flutter Visuals Calendar Widget.
/// Displays a calendar with a header that shows the current month.
/// The calendar can be displayed in day or week format.
/// params [Event] The events to display.
/// params [CalendarFormat] The calendar format. [day, week]
class VisualsCalendar extends StatefulWidget {
  // The events.
  final List<Event> events;
  // The calendar format. [day, week]
  final CalendarFormat calendarFormat;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const VisualsCalendar({
    super.key,
    required this.calendarFormat,
    required this.events,
    this.eventBuilder,
  });

  @override
  State<StatefulWidget> createState() => VisualsCalendarState();
}

class VisualsCalendarState extends State<VisualsCalendar> {
  // The events.
  late List<Event> events;

  // Create a page controller to control the calendar pages.
  PageController pageController = PageController(initialPage: 100);

  // Initialize the focused data, represents current day.
  DateTime focusedDate = DateTime.now();

  // Initialize the focused month, used for displaying month in focus.
  String focusedMonth = DateFormat.MMMM().format(DateTime.now());

  // Initialize the calendar format.
  CalendarFormat _calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    super.initState();
    // Set the events.
    events = widget.events;
    // Set the calendar format.
    _calendarFormat = widget.calendarFormat;
  }

  // Set the calendar format.
  void setFormat(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }

  // Set the page to the current date.
  void setToday() {
    pageController.animateToPage(
      100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Set the focused month based on the index.
  // This is used to update the month in the app bar.
  void setFocusedMonth(int index) {
    // Normalize the index.
    final nIndex = index - 100;
    // Get the date based on the index.
    DateTime nDate = focusedDate.add(
      Duration(days: calendarFormatInts[_calendarFormat]! * nIndex),
    );

    setState(() {
      // Update the focused month with formatted date.
      focusedMonth = DateFormat.MMMM().format(nDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    events = widget.events;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(focusedMonth),
        actions: getActions(),
      ),
      body: PageView.builder(
        controller: pageController,
        onPageChanged: setFocusedMonth,
        itemBuilder: (context, index) {
          // Normalize the index.
          final normalizedIndex = index - 100;

          // Get the dates to be displayed, this varies based on calendar format.
          List<DateTime> dates = getDisplayedDates(
            focusedDate,
            _calendarFormat,
            normalizedIndex,
          );

          return Column(
            children: [
              // Display the dates row.
              if (_calendarFormat != CalendarFormat.day)
                DatesRow(
                  calendarFormat: _calendarFormat,
                  dates: dates,
                ),
              // Display the all day events row.
              AllDayEventsRow(
                events:
                    events.where((event) => event.isAllDay == true).toList(),
                dates: dates,
                calendarFormat: _calendarFormat,
              ),
              // Display the calendar section.
              Expanded(
                child: CalendarSection(
                  events:
                      events.where((event) => event.isAllDay != true).toList(),
                  calendarFormat: _calendarFormat,
                  dates: dates,
                  eventBuilder: widget.eventBuilder,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // Get the actions for the app bar.
  List<Widget> getActions() {
    return [
      IconButton(
        icon: const Icon(Icons.today),
        onPressed: setToday,
      ),
      PopupMenuButton<CalendarFormat>(
        onSelected: setFormat,
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: CalendarFormat.day,
              child: Text('Day'),
            ),
            const PopupMenuItem(
              value: CalendarFormat.threeDays,
              child: Text('3 Days'),
            ),
            const PopupMenuItem(
              value: CalendarFormat.week,
              child: Text('Week'),
            ),
            const PopupMenuItem(
              value: CalendarFormat.weekDays,
              child: Text('Week days'),
            ),
          ];
        },
      ),
    ];
  }
}
