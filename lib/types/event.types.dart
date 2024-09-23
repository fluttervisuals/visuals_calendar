import 'package:flutter/material.dart';

/// Type definitions for Events
/// params [start] The start date of the event.
/// params [end] The end date of the event.
/// params [title] The title of the event.
/// params [color] The color of the event.
/// params [isAllDay] Is the event an all day event.
/// params [description] The description of the event.
/// params [location] The location of the event.
/// returns [Event] The event.
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
  // Description of the event
  final String? description;
  // Location of the event
  final String? location;
  // On tap event
  final Function? onTap;

  Event(
    this.start,
    this.title,
    this.color, {
    this.end,
    this.isAllDay,
    this.description,
    this.location,
    this.onTap,
  });
}

// The selection ID for an event selection, used for adding a new event.
const selectionID = '8060957c-0b21-44da-8965-016b6c7a5c31';
