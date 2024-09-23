import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/canvas/calendar_section.dart';
import 'components/canvas/hours.dart';
import 'defaults/action_menu.dart';
import 'functions/focused_day.dart';
import 'functions/max_daily_events.dart';
import 'functions/page_index.dart';
import 'theme.dart';
import 'types/calendar_format.types.dart';
import 'types/event.types.dart';

/// A Flutter Visuals Calendar Widget.
/// Displays a calendar with a header that shows the current month.
/// The calendar can be displayed in day or week format.
/// params [Event] The events to display.
/// params [CalendarFormat] The calendar format. [day, week]
/// params [Widget] The event tile builder.
/// params [AppBar] The app bar builder.
class VisualsCalendar extends StatefulWidget {
  // The events.
  final List<Event>? events;
  // Future events
  final Future<List<Event>>? futureEvents;
  // The calendar format. [day, week]
  final CalendarFormat defaultFormat;
  // The event tile builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;
  // App bar builder.
  final AppBar Function(
    BuildContext context,
    String currentMonth,
    void Function() setToday,
    void Function(CalendarFormat) setFormat,
    List<CalendarFormat> avalableFormats,
  )? appBarBuilder;
  // Enable selection for creating a new event.
  final bool? selectionEnabled;
  // Callback for selecting time to create a new event.
  final void Function(DateTime start, DateTime end)? onTimeSelected;
  // Style
  final CalendarStyle? style;

  const VisualsCalendar({
    super.key,
    required this.defaultFormat,
    this.events,
    this.futureEvents,
    this.eventBuilder,
    this.appBarBuilder,
    this.selectionEnabled,
    this.onTimeSelected,
    this.style,
  });

  @override
  State<StatefulWidget> createState() => VisualsCalendarState();
}

class VisualsCalendarState extends State<VisualsCalendar> {
  // Initialize the events.
  List<Event> events = [];

  // Future events
  late Future<List<Event>> futureEvents;

  // The loading state.
  bool loading = false;

  // Initialize the focused month, used for displaying month in focus.
  String focusedMonth = DateFormat.MMMM().format(DateTime.now());

  // Initialize the calendar format.
  late CalendarFormat _calendarFormat;

  // Initialize the page controller
  late PageController pageController;

  // The page index
  late int pageIndex;

  // Main scroll controller
  final ScrollController _mainController = ScrollController(
    initialScrollOffset: 750,
  );

  // The scroll base, used for directional scaling.
  double _scrollBase = 450;

  // Default container height, used for directional scaling.
  double _containerHeight = 2400;

  // Default base height, used for directional scaling.
  double _baseHeight = 100.0;

  // Set the daily expanded state.
  bool dailyExpanded = false;

  // Set the max daily events.
  int maxDailyEvents = 0;

  @override
  void initState() {
    super.initState();
    // Set the calendar format.
    _calendarFormat = widget.defaultFormat;

    // Set the page index.
    pageIndex = getPageIndex(_calendarFormat);

    // Initialize the page controller.
    pageController = PageController(
      keepPage: false,
      initialPage: pageIndex,
      viewportFraction: 1 / calendarFormatInts[widget.defaultFormat]!,
    );

    // Set the events
    if (widget.events != null) {
      events = widget.events!;
      setState(() {
        maxDailyEvents = getMaxDailyEvents(events, pageIndex, _calendarFormat);
      });
    }
    // Set the future events.
    if (widget.futureEvents != null) {
      futureEvents = widget.futureEvents!;
      loading = true;
      futureEvents.then((value) {
        setState(() {
          events = value;
          loading = false;
          maxDailyEvents =
              getMaxDailyEvents(events, pageIndex, _calendarFormat);
        });
      });
    }
  }

  // Set the calendar format.
  void setFormat(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });

    pageController = PageController(
      keepPage: false,
      initialPage: getPageIndex(format),
      viewportFraction: 1 / calendarFormatInts[format]!,
    );
  }

  // Set the page to the current date.
  void setToday() {
    pageController.animateToPage(
      100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Set the daily expanded state.
  void setDailyExpanded() {
    setState(() {
      dailyExpanded = !dailyExpanded;
    });
  }

  // Set the page index, updated when page is changed.
  void setPageIndex(int index) {
    setState(() {
      pageIndex = index;
      maxDailyEvents = getMaxDailyEvents(events, index, _calendarFormat);
      focusedMonth =
          DateFormat.MMMM().format(getFocusedDate(index, _calendarFormat));
    });
  }

  // Update the container size based on the vertical scale from pinch zoom.
  void _updateContainerSize(double verticalScale) {
    // Jump to the new position based on the vertical scale.
    _mainController
        .jumpTo(_scrollBase + (_baseHeight / 2) * (verticalScale - 1));

    // Calculate the new height based on the vertical scale.
    final newHeight = _baseHeight * verticalScale;

    setState(() {
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
    return Scaffold(
      appBar: widget.appBarBuilder != null
          ? widget.appBarBuilder!(
              context,
              focusedMonth,
              setToday,
              setFormat,
              calendarFormatInts.keys.toList(),
            )
          : AppBar(
              centerTitle: false,
              title: Text(focusedMonth),
              actions: getActions(setToday, setFormat),
              forceMaterialTransparency: true,
              backgroundColor: widget.style?.headerColor,
            ),
      body: Column(
        children: [
          if (loading)
            const LinearProgressIndicator(backgroundColor: Colors.transparent),
          Expanded(
            child: Row(
              children: [
                HourColumn(
                  focusedDate: getFocusedDate(pageIndex, _calendarFormat),
                  calendarFormat: _calendarFormat,
                  height: _containerHeight,
                  scrollController: _mainController,
                  setDailyExpanded: setDailyExpanded,
                  maxDailyEvents: maxDailyEvents,
                  isDailyExpanded: dailyExpanded,
                  style: widget.style,
                  loading: loading,
                ),
                Expanded(
                  child: CalendarSection(
                    events: events,
                    calendarFormat: _calendarFormat,
                    pageController: pageController,
                    mainController: _mainController,
                    onScaleUpdate: (ScaleUpdateDetails details) {
                      _updateContainerSize(details.verticalScale);
                    },
                    onScaleStart: (ScaleStartDetails details) {
                      _baseHeight = _containerHeight;
                      _scrollBase = _mainController.offset;
                    },
                    onPageChanged: setPageIndex,
                    maxDailyEvents: maxDailyEvents,
                    dailyEventsExpanded: dailyExpanded,
                    height: _containerHeight,
                    style: widget.style,
                    selectionEnabled: widget.selectionEnabled ?? false,
                    onTimeSelected: widget.onTimeSelected,
                    loading: loading,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
