import '../types/event.types.dart';

/// Filter the events for the current date.
/// params [Event] events The events to filter.
/// params [DateTime] date The date to filter.
List<Event> filterEventsByDay(List<Event> events, DateTime date) {
  return events.where((event) {
    return event.start.day == date.day &&
        event.start.month == date.month &&
        event.start.year == date.year;
  }).toList();
}
