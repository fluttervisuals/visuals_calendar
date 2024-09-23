/// This function returns the expanded header height based on the number of events in the day, used for the daily expanded view.
/// The expanded header height is used to calculate the height of the event column.
double getExpandedHeaderHeight(int numEvents, {bool isExpanded = false}) {
  if (numEvents == 0) {
    return 0;
  } else if (numEvents == 1) {
    return 35;
  } else if (numEvents == 2) {
    return 70;
  } else if (!isExpanded) {
    return 80;
  } else if (numEvents == 3) {
    return 85;
  } else if (numEvents == 4) {
    return 110;
  } else if (numEvents == 5) {
    return 135;
  } else if (numEvents == 6) {
    return 160;
  } else if (numEvents == 7) {
    return 185;
  } else if (numEvents == 8) {
    return 210;
  } else if (numEvents == 9) {
    return 235;
  } else if (numEvents == 10) {
    return 260;
  } else {
    return 285;
  }
}

/// This function returns the header height for the day format based on the number of events in the day.
/// The header height is used to calculate the height of the event column.
double getDayFormatHeaderHeight(int numEvents, {bool isExpanded = false}) {
  if (numEvents == 0 || numEvents == 1 || numEvents == 2) {
    return 70;
  } else if (!isExpanded) {
    return 110;
  } else if (numEvents == 3) {
    return 110;
  } else if (numEvents == 4) {
    return 110;
  } else if (numEvents == 5) {
    return 135;
  } else if (numEvents == 6) {
    return 160;
  } else if (numEvents == 7) {
    return 185;
  } else if (numEvents == 8) {
    return 210;
  } else if (numEvents == 9) {
    return 235;
  } else if (numEvents == 10) {
    return 260;
  } else {
    return 285;
  }
}
