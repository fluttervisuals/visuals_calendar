import '../types/event.types.dart';

// Iterates through  the daily events and organizes them into a grid.
// We need this to handle overlapping of events.
// params [events] The events to organize.
List<List<Event?>> getCalendarGrid(
  // The events to organize.
  List<Event> events,
) {
  // Sort the events by start date.
  events.sort((a, b) => a.start.compareTo(b.start));

  // Check for overlapping events.
  List<List<Event?>> grid = [];

  for (int i = 0; i < events.length; i++) {
    List<Event?> overlaps = events
        .getRange(i + 1, events.length)
        .toList()
        .where((e) => e.start.isBefore(events[i].end!))
        .toList();

    if (overlaps.isNotEmpty) {
      grid.add([events[i], ...overlaps]);
      i = i + overlaps.length;
    } else {
      grid.add([events[i]]);
    }
  }

  return grid;
}
