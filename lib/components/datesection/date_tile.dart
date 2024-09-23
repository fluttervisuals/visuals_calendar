import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../functions/dates.dart';
import '../../theme.dart';

/// A tile that displays a date.
/// params [DateTime] The date to display.
class DateTile extends StatelessWidget {
  // The date to display.
  final DateTime date;
  // The style for the date tile.
  final CalendarStyle? style;
  const DateTile({super.key, required this.date, this.style});

  @override
  Widget build(BuildContext context) {
    bool isToday = isDateToday(date);
    Color primary = Theme.of(context).colorScheme.primary;
    Color onPrimary = Theme.of(context).colorScheme.onPrimary;
    Color onSurface = Theme.of(context).colorScheme.onSurface;

    // Text style for the date tile.

    final textStyle = style?.dateTextStyle?.copyWith(
          color: isToday ? primary : onSurface,
          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
        ) ??
        TextStyle(
          color: isToday ? primary : onSurface,
          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
        );

    return Column(
      children: [
        // Name of day in short format (e.g. Mon)
        Text(DateFormat('EEE').format(date), style: textStyle),
        // Date number inside a circle
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToday ? primary : Colors.transparent,
          ),
          child: Center(
            child: Text(date.day.toString(),
                style: TextStyle(
                  color: isToday ? onPrimary : onSurface,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
      ],
    );
  }
}
