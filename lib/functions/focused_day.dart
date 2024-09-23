import '../types/calendar_format.types.dart';
import 'page_index.dart';

/// Get the focused date for the current index.
/// params [int] index The index to get the date for.
/// params [CalendarFormat] calendarFormat The calendar format.
DateTime getFocusedDate(int index, CalendarFormat calendarFormat) {
  return DateTime.now().add(
    Duration(days: normalizePageIndex(index, calendarFormat)),
  );
}
