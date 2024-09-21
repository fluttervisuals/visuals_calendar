import '../types/calendar_format.types.dart';
import '../types/event.types.dart';

/// Returns true if the two dates are the same.
/// params [DateTime] The first date.
/// params [DateTime] The second date.
bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

/// Returns true if the date is today.
/// params [DateTime] The date to check.
bool isDateToday(DateTime date) {
  return isSameDate(date, DateTime.now());
}

/// Returns true if the event is in the past
/// (i.e. the end date is before the current date).
/// params [Event] The event to check.
/// returns [bool] True if the event is in the past.
bool isEventPast(Event event) {
  return (event.end != null && event.end!.isBefore(DateTime.now())) ||
      event.start.add(const Duration(hours: 1)).isBefore(DateTime.now());
}

/// Returns true if the event is before today.
/// params [Event] The event to check.
/// returns [bool] True if the event is before today.
bool isEventBeforeToday(Event event) {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  return DateTime(event.start.year, event.start.month, event.start.day)
      .isBefore(today);
}

/// Returns the dates to be displayed in the calendar.
/// params [DateTime] The focused date.
/// params [CalendarFormat] The calendar format. [day, week]
/// params [int] The page index.
List<DateTime> getDisplayedDates(
  DateTime focusedDate,
  CalendarFormat format,
  int index,
) {
  List<DateTime> dates = [];

  switch (format) {
    case CalendarFormat.day:
      dates.add(focusedDate.add(Duration(days: index)));
      break;

    case CalendarFormat.week:
      // Normalize the date from the index
      final normalizedDate = focusedDate.add(Duration(days: 7 * index));

      // Return the dates for the week starting from the first day of the week
      DateTime firstDayOfWeek =
          normalizedDate.subtract(Duration(days: normalizedDate.weekday - 1));
      for (int i = 0; i < 7; i++) {
        dates.add(firstDayOfWeek.add(Duration(days: i)));
      }
      break;
    case CalendarFormat.weekDays:
      // Normalize the date from the index
      final normalizedDate = focusedDate.add(Duration(days: 7 * index));
      // Return the dates for the week starting from Monday
      DateTime firstDayOfWeek =
          normalizedDate.subtract(Duration(days: normalizedDate.weekday - 1));
      for (int i = 0; i < 5; i++) {
        dates.add(firstDayOfWeek.add(Duration(days: i)));
      }
      break;

    case CalendarFormat.threeDays:
      // Normalize the date from the index
      final normalizedDate = focusedDate.add(Duration(days: 3 * index));

      // Return the dates for the week starting from Monday
      DateTime firstDayOfWeek =
          normalizedDate.subtract(const Duration(days: 1));
      for (int i = 0; i < 3; i++) {
        dates.add(firstDayOfWeek.add(Duration(days: i)));
      }
      break;
  }

  return dates;
}

/// Rounds down time to the nearest quarter.
/// params [DateTime] date The date to round.
/// returns [DateTime] The rounded date.
DateTime roundUpQuarter(DateTime date) {
  final minutes = date.minute;
  if (minutes < 15) {
    return DateTime(date.year, date.month, date.day, date.hour, 0);
  } else if (minutes < 30) {
    return DateTime(date.year, date.month, date.day, date.hour, 15);
  } else if (minutes < 45) {
    return DateTime(date.year, date.month, date.day, date.hour, 30);
  } else {
    return DateTime(date.year, date.month, date.day, date.hour, 45);
  }
}

/// Returns the date time from the offset of the scroll.
DateTime getDateTimeFromOffset(
    double offset, double hourHeight, DateTime date) {
  final hour = offset ~/ hourHeight;
  final minute = ((offset % hourHeight) / hourHeight * 60).round();
  return roundUpQuarter(
      DateTime(date.year, date.month, date.day, hour, minute));
}
