import 'package:flutter/material.dart';

import '../../functions/dates.dart';
import '../../types/event.types.dart';

/// A tile that displays an all day event.
/// params [Event] The event to display.
class AllDayEventTile extends StatelessWidget {
  final Event event;
  const AllDayEventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0, top: 4.0),
      child: Container(
        alignment: Alignment.centerLeft,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color:
              isEventPast(event) ? event.color.withOpacity(0.5) : event.color,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(
            event.title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isEventPast(event) ? Colors.grey[800] : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
