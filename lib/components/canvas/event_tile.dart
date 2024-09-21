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
      child: (event.title == selectionID)
          ? SelectionTile(event: event)
          : eventBuilder != null
              ? eventBuilder!(context, event)
              : DefaultTile(event: event),
    );
  }
}

class SelectionTile extends StatelessWidget {
  final Event event;
  const SelectionTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey[400]!, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0),
            child: Text(
              '(No Title)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0),
            child: Text(
              '${DateFormat.Hm().format(event.start)} - ${DateFormat.Hm().format(event.end!)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class DefaultTile extends StatelessWidget {
  final Event event;

  const DefaultTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final past = isEventPast(event);

    final tileColor =
        past ? event.color.withOpacity(0.2) : event.color.withOpacity(0.5);

    final textColor = Theme.of(context).colorScheme.onSurface;

    final titleStyle = textTheme.bodySmall?.copyWith(
      color: textColor,
      fontWeight: FontWeight.bold,
    );

    final subtitleStyle = textTheme.bodySmall?.copyWith(color: textColor);

    return Container(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipPath(
        clipper: ShapeBorderClipper(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: tileColor, width: 4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0),
                child: Text(event.title, style: titleStyle),
              ),
              if (event.location != null)
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Text(event.location!, style: subtitleStyle),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                child: Text(DateFormat.Hm().format(event.start),
                    style: subtitleStyle),
              ),
              if (event.description != null)
                Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Text(event.description!, style: subtitleStyle),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
