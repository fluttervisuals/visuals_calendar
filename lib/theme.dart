import 'package:flutter/material.dart';

/// The styles for the calendar.
/// Adapt the colors and text styles for the component.
class CalendarStyle {
  // The background color of the calendar.
  final Color? backgroundColor;
  // The color of the header.
  final Color? headerColor;

  // The text style of the date in the header.
  final TextStyle? dateTextStyle;
  // The text style of the hour indicators on the left.
  final TextStyle? hourTextStyle;

  // The text style of the event title, if using default event tiles.
  final TextStyle? eventTitleTextStyle;
  // The text style of the event description, if using default event tiles.
  final TextStyle? eventDescriptionTextStyle;

  // The color of the loading indicator.
  final Color? loadingIndicatorColor;
  // The color of the time indicator.
  final Color? timeIndicatorColor;
  // The color of the today indicator.
  final Color? todayIndicatorColor;

  CalendarStyle({
    this.backgroundColor,
    this.headerColor,
    this.dateTextStyle,
    this.hourTextStyle,
    this.eventTitleTextStyle,
    this.eventDescriptionTextStyle,
    this.loadingIndicatorColor,
    this.timeIndicatorColor,
    this.todayIndicatorColor,
  });
}
