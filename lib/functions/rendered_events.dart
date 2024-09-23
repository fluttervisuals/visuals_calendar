import '../types/calendar_format.types.dart';
import '../types/event.types.dart';
import 'dates.dart';
import 'page_index.dart';

/// Get the events displayed in the current viewport.
/// params [Event] events The events to render.
/// params [int] index The current index.
/// params [CalendarFormat] format The calendar format.
List<Event> getRenderedEvents(
  List<Event> events,
  int index,
  CalendarFormat format,
) {
  int normalizedIndex = normalizePageIndex(index, format);
  DateTime now = DateTime.now();
  switch (format) {
    case CalendarFormat.day:
      return events.where((event) {
        return isSameDate(
            event.start, now.add(Duration(days: normalizedIndex)));
      }).toList();
    case CalendarFormat.threeDays:
      return events.where((event) {
        return event.start.isAfter(
                startOfDay(now.add(Duration(days: normalizedIndex - 1)))) &&
            event.start.isBefore(
                endOfDay(now.add(Duration(days: normalizedIndex + 1))));
      }).toList();
    case CalendarFormat.week:
      return events.where((event) {
        return event.start.isAfter(
                startOfDay(now.add(Duration(days: normalizedIndex - 3)))) &&
            event.start.isBefore(
                endOfDay(now.add(Duration(days: normalizedIndex + 3))));
      }).toList();
  }
}
