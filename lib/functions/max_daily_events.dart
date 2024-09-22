import 'package:intl/intl.dart';

import '../types/calendar_format.types.dart';
import '../types/event.types.dart';
import 'rendered_events.dart';

/// Get the maximum number of daily events in the current viewport.
/// params [Event] events The events to render.
/// params [int] index The current index.
/// params [CalendarFormat] calendarFormat The calendar format.
int getMaxDailyEvents(
  List<Event> events,
  int index,
  CalendarFormat calendarFormat,
) {
  List<Event> renderedDailyEvents = getRenderedEvents(
      events.where((e) => e.isAllDay == true).toList(), index, calendarFormat);

  final dates =
      renderedDailyEvents.map((e) => DateFormat('yyyy-MM-dd').format(e.start));

  // Get the maximum number of daily events.
  int maxDailyEvents = 0;
  for (var date in dates) {
    final count = dates.where((d) => d == date).length;
    if (count > maxDailyEvents) {
      maxDailyEvents = count;
    }
  }

  return maxDailyEvents;
}
