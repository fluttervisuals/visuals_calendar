import 'package:flutter/material.dart';

/// Create an event column for a specific date.
/// params [double] verticalScale for directional scrolling.
class CurrentTimeMarker extends StatelessWidget {
  // The vertical scale, used for directional scaling.
  final double hourHeight;
  const CurrentTimeMarker({super.key, required this.hourHeight});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8 + (DateTime.now().hour + DateTime.now().minute / 60) * hourHeight,
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
          Container(
            width: 1000,
            height: 2,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
