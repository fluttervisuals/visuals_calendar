import 'package:flutter/material.dart';

import '../../functions/header_height.dart';
import '../../theme.dart';
import '../../types/calendar_format.types.dart';
import '../datesection/date_tile.dart';

/// A column of hours on the left.
class HourColumn extends StatefulWidget {
  final double height;
  final DateTime focusedDate;
  final CalendarFormat calendarFormat;
  final ScrollController scrollController;
  final Function setDailyExpanded;
  final bool isDailyExpanded;
  final int maxDailyEvents;
  final CalendarStyle? style;
  final bool loading;

  const HourColumn({
    super.key,
    required this.height,
    required this.focusedDate,
    required this.calendarFormat,
    required this.scrollController,
    required this.setDailyExpanded,
    required this.isDailyExpanded,
    required this.maxDailyEvents,
    required this.loading,
    this.style,
  });

  @override
  State<StatefulWidget> createState() => HourColumnState();
}

class HourColumnState extends State<HourColumn> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = widget.scrollController;
  }

  @override
  Widget build(BuildContext context) {
    double dailyEventsHeight = getExpandedHeaderHeight(
          widget.maxDailyEvents,
          isExpanded: widget.isDailyExpanded,
        ) +
        60;

    double dayFormatEventsHeight = getDayFormatHeaderHeight(
      widget.maxDailyEvents,
      isExpanded: widget.isDailyExpanded,
    );

    double dynamicHeight = widget.calendarFormat == CalendarFormat.day
        ? dayFormatEventsHeight
        : dailyEventsHeight;

    return Row(
      children: [
        Column(
          children: [
            Container(
              width: 50,
              color: widget.style?.headerColor,
              height: dynamicHeight,
              child: Column(
                children: [
                  if (widget.calendarFormat == CalendarFormat.day)
                    DateTile(date: widget.focusedDate, style: widget.style),
                  if (widget.maxDailyEvents > 2)
                    IconButton(
                      icon: Icon(
                        widget.isDailyExpanded
                            ? Icons.arrow_drop_up
                            : Icons.arrow_drop_down,
                      ),
                      onPressed: () => widget.setDailyExpanded(),
                    )
                ],
              ),
            ),
            Container(
              color: widget.style?.backgroundColor,
              width: 50,
              alignment: Alignment.bottomCenter,
              child: widget.loading
                  ? Container()
                  : const Divider(height: 1, thickness: 1),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Container(
                  color: widget.style?.backgroundColor,
                  height: widget.height,
                  width: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      for (int i = 0; i < 24; i++)
                        Expanded(
                          child: Text(
                            '$i:00',
                            style: widget.style?.hourTextStyle ??
                                const TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(height: 60),
            Expanded(
              child: widget.loading
                  ? Container()
                  : const VerticalDivider(
                      width: 0.5,
                      thickness: 0.5,
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
