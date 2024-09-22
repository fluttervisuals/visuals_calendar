import 'package:flutter/material.dart';

import '../../functions/header_height.dart';

/// A column of hours on the left.
class HourColumn extends StatefulWidget {
  final double height;
  final ScrollController scrollController;
  final Function setDailyExpanded;
  final bool isDailyExpanded;
  final int maxDailyEvents;

  const HourColumn({
    super.key,
    required this.height,
    required this.scrollController,
    required this.setDailyExpanded,
    required this.isDailyExpanded,
    required this.maxDailyEvents,
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
    return Column(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: widget.isDailyExpanded
              ? getExpandedHeaderHeight(widget.maxDailyEvents) + 60
              : getHeaderHeight(widget.maxDailyEvents) + 60,
          child: widget.maxDailyEvents > 2
              ? IconButton(
                  icon: Icon(
                    widget.isDailyExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                  ),
                  onPressed: () => widget.setDailyExpanded(),
                )
              : const SizedBox(),
        ),
        Container(
            width: 50,
            alignment: Alignment.bottomCenter,
            child: const Divider(height: 1, thickness: 1)),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: scrollController,
            child: SizedBox(
              height: widget.height,
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
            ),
          ),
        ),
      ],
    );
  }
}
