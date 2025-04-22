import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../functions/dates.dart';
import '../../theme.dart';
import '../../types/event.types.dart';

/// A tile that displays an event.
/// params [Event] The event to display.
class EventTile extends StatelessWidget {
  // The event to display.
  final Event event;
  // The event builder.
  final Widget Function(BuildContext context, Event event)? eventBuilder;
  // Calendar style
  final CalendarStyle? style;

  const EventTile({
    super.key,
    required this.event,
    this.eventBuilder,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => event.onTap?.call(),
      child: SizedBox(
        width: double.infinity,
        child: (event.title == selectionID)
            ? SelectionTile(event: event, style: style)
            : eventBuilder != null
                ? eventBuilder!(context, event)
                : DefaultTile(event: event, style: style),
      ),
    );
  }
}

/// A selection tile.
/// params [Event] The selection event to display.
/// params [CalendarStyle] The style for the selection tile.
class SelectionTile extends StatelessWidget {
  // The selection event to display.
  final Event event;
  // The style for the selection tile.
  final CalendarStyle? style;

  const SelectionTile({super.key, required this.event, this.style});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).colorScheme.onSurface;

    final titleStyle = style?.eventTitleTextStyle ??
        textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        );

    final subtitleStyle = style?.eventDescriptionTextStyle ??
        textTheme.bodySmall?.copyWith(
          color: textColor,
        );

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
            child: Text('(No Title)', style: titleStyle),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0),
            child: Text(
              '${DateFormat.Hm().format(event.start)} - ${DateFormat.Hm().format(event.end!)}',
              style: subtitleStyle,
            ),
          ),
        ],
      ),
    );
  }
}

/// A default event tile.
/// params [Event] The event to display.
/// params [CalendarStyle] The style for the event tile.
class DefaultTile extends StatelessWidget {
  // The event to display.
  final Event event;
  // The style for the event tile.
  final CalendarStyle? style;

  const DefaultTile({super.key, required this.event, this.style});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final textColor = Theme.of(context).colorScheme.onSurface;

    final past = isEventPast(event);

    final tileColor = past
        ? event.color.withValues(alpha: .2)
        : event.color.withValues(alpha: 0.5);

    final titleStyle = style?.eventTitleTextStyle ??
        textTheme.bodySmall?.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip);

    final subtitleStyle = style?.eventDescriptionTextStyle ??
        textTheme.bodySmall?.copyWith(
          color: textColor,
          overflow: TextOverflow.clip,
        );

    return Container(
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
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
              if (event.label != null) const Spacer(),
              if (event.label != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, right: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      event.label ?? '',
                      style: subtitleStyle?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
