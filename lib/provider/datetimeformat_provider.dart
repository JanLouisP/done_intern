import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DateTimeFormatProvider extends ChangeNotifier{

  //Formats the Text printed to the user.
  String formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(Duration(days: 1));

    if (date.isAtSameMomentAs(today)) {
      return "When can we call you \nToday?";
    } else if (date.isAtSameMomentAs(tomorrow)) {
      return "When can we call you \nTomorrow?";
    } else if (date.isBefore(today.add(Duration(days: 7)))) {
      return "When can we call you on\n${DateFormat('EEEE').format(date)}?";
    } else {
      return "When can we call you on\n${DateFormat('d MMMM yyyy').format(date)}?";
    }
  }

}