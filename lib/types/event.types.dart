import 'package:flutter/material.dart';

/// Type definitions for Events
/// params [start] The start date of the event.
/// params [end] The end date of the event.
/// params [title] The title of the event.
/// params [color] The color of the event.
class Event {
  // Start date and time of the event
  final DateTime start;
  // End date and time of the event
  final DateTime? end;
  // Title of the event
  final String title;
  // Color of the event
  final Color color;
  // Is the event an all day event
  final bool? isAllDay;

  Event(
    this.start,
    this.end,
    this.title,
    this.color, {
    this.isAllDay,
  });
}
