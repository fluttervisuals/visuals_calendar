import 'package:flutter/material.dart';

import '../../functions/dates.dart';
import '../../theme.dart';
import '../../types/event.types.dart';

/// A tile that displays an all day event.
/// params [Event] The event to display.
class AllDayEventTile extends StatelessWidget {
  final Event event;
  final CalendarStyle? style;
  const AllDayEventTile({super.key, required this.event, this.style});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final past = isEventBeforeToday(event);

    final tileColor =
        past ? event.color.withOpacity(0.2) : event.color.withOpacity(0.5);

    final textColor = Theme.of(context).colorScheme.onSurface;

    final titleStyle = style?.eventTitleTextStyle ??
        textTheme.bodySmall?.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        );

    return Padding(
      padding: const EdgeInsets.only(right: 4.0, top: 4.0),
      child: GestureDetector(
        onTap: () => event.onTap,
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          ),
          child: Container(
            alignment: Alignment.centerLeft,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: tileColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                event.title,
                style: titleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
