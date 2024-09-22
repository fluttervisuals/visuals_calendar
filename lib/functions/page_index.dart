import '../types/calendar_format.types.dart';

// The default page index.
int defaultPageIndex = 100;

/// Get the page index for the current calendar format.
/// params [CalendarFormat] calendarFormat The calendar format.
int getPageIndex(CalendarFormat calendarFormat) {
  switch (calendarFormat) {
    case CalendarFormat.day:
      return defaultPageIndex;
    case CalendarFormat.threeDays:
      return defaultPageIndex;
    case CalendarFormat.week:
      return defaultPageIndex;
  }
}

/// Normalize the page index for the current calendar format.
/// params [int] index The index to normalize.
/// params [CalendarFormat] calendarFormat The calendar format.
int normalizePageIndex(int index, CalendarFormat calendarFormat) {
  switch (calendarFormat) {
    case CalendarFormat.day:
      return index - defaultPageIndex;
    case CalendarFormat.threeDays:
      return index - defaultPageIndex;
    case CalendarFormat.week:
      return index - defaultPageIndex;
  }
}
