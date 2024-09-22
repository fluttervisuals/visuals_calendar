/// Enumerated values for different calendar formats
enum CalendarFormat {
  // 1 day displayed
  day,
  // 7 days displayed
  week,
  // 3 days displayed
  threeDays,
}

/// Integers for the different calendar formats
final Map<CalendarFormat, int> calendarFormatInts = {
  CalendarFormat.day: 1,
  CalendarFormat.week: 7,
  CalendarFormat.threeDays: 3,
};
