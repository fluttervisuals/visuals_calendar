import 'package:flutter/material.dart';

/// A column of hours on the left.
class HourColumn extends StatelessWidget {
  const HourColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          for (int i = 0; i < 24; i++)
            Expanded(
              child: Text(
                '$i:00',
                style: const TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }
}
