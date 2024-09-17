import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../functions/dates.dart';

/// A tile that displays a date.
/// params [DateTime] The date to display.
class DateTile extends StatelessWidget {
  // The date to display.
  final DateTime date;
  const DateTile({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    bool isToday = isDateToday(date);

    return Column(
      children: [
        // Name of day in short format (e.g. Mon)
        Text(
          DateFormat('EEE').format(date),
          style: TextStyle(
            color: isToday ? Colors.blue : Colors.black,
            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        // Date number inside a circle
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isToday ? Colors.blue : Colors.transparent,
          ),
          child: Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
