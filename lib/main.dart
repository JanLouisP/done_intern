import 'package:doneintern/provider/datetimeformat_provider.dart';
import 'package:doneintern/provider/progressindicator_provider.dart';
import 'package:doneintern/provider/timeslots_provider.dart';
import 'package:doneintern/screens/timeslots_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  //Here you can play arround with different dates.
  //year, month, day, .....
  DateTime date = DateTime(2023, 12, 10, 0, 0, 0, 0, 0);
  runApp(
    MaterialApp(
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeSlotsProvider>(
            create: (_) => TimeSlotsProvider(date: date),
          ),
          ChangeNotifierProvider<ProgressIndicatorProvider>(
            create: (_) => ProgressIndicatorProvider(),
          ),
          ChangeNotifierProvider<DateTimeFormatProvider>(
            create: (_) => DateTimeFormatProvider(),
          ),
        ],
        //Use this to play around with the Dates which get handed to the widget.
        child: TimeSlotsScreen(dateTime: date),
      ),
      routes: {
        '/timeSlotsScreen': (context) =>
            TimeSlotsScreen(dateTime: DateTime.now()),
      },
    ),
  );
}
