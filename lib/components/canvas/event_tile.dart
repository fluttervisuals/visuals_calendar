import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../functions/dates.dart';
import '../../types/event.types.dart';

/// A tile that displays an event.
/// params [Event] The event to display.
class EventTile extends StatelessWidget {
  // The event to display.
  final Event event;
  // The event builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;

  const EventTile({super.key, required this.event, this.eventBuilder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: eventBuilder != null
          ? eventBuilder!(context, event)
          : DefaultTile(event: event),
    );
  }
}

class DefaultTile extends StatelessWidget {
  final Event event;

  const DefaultTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // If end date in the past, set color to grey.
        color: isEventPast(event) ? event.color.withOpacity(0.5) : event.color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              event.title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isEventPast(event) ? Colors.grey[800] : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, right: 2.0),
            child: Text(
              '${DateFormat.Hm().format(event.start)} - ${DateFormat.Hm().format(
                event.end ?? event.start.add(const Duration(hours: 1)),
              )}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isEventPast(event) ? Colors.grey[800] : Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
