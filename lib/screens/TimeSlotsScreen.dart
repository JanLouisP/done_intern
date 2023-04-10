import 'package:doneintern/provider/DateTimeFormatProvider.dart';
import 'package:doneintern/provider/ProgressIndicatorProvider.dart';
import 'package:doneintern/provider/TimeSlotsProvider.dart';
import 'package:doneintern/widgets/MyElevatedButton.dart';
import 'package:doneintern/widgets/MyGridView.dart';
import 'package:doneintern/widgets/MyProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TimeSlotsScreen extends StatelessWidget {
  //The DateTime which is handed to the widget.
  final dateTime;

  const TimeSlotsScreen({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const MyProgessBar(),
          leading: IconButton(
            iconSize: 25,
            splashRadius: 20,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              //Is just for testing the progressbar.
              Provider.of<ProgressIndicatorProvider>(context, listen: false)
                  .currentPage = 4;
              Provider.of<ProgressIndicatorProvider>(context, listen: false)
                  .updateProgress();
              //TODO: Back to previous page in Booking Flow
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SafeArea(
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, top: 32),
                                child: Text(
                                  Provider.of<DateTimeFormatProvider>(context, listen: false).formatDate(dateTime),
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, top: 10, right: 20),
                                child: Text(
                                  "Choose as many as you want",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: MyGridView(
                                elements: Provider.of<TimeSlotsProvider>(context, listen: false)
                                    .zones,
                                listName: "Zones",
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                child: Text(
                                  "Morning",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 30),
                              child: MyGridView(
                                elements: Provider.of<TimeSlotsProvider>(context,
                                        listen: false)
                                    .timesMorning,
                                listName: "Morning",
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                child: Text(
                                  "Afternoon",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 30),
                              child: MyGridView(
                                elements: Provider.of<TimeSlotsProvider>(context,
                                        listen: false)
                                    .timesAfternoon,
                                listName: "Afternoon",
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                child: Text(
                                  "Evening",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 30),
                              child: MyGridView(
                                elements: Provider.of<TimeSlotsProvider>(context,
                                        listen: false)
                                    .timesEvening,
                                listName: "Evening",
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20, right: 20, left: 20),
                  child: MyElevatedButton(
                      onPressed: () {
                        //If at least one element is selected, we can move on in our flow and use the
                        //selected DateTime objects.
                        if (Provider.of<TimeSlotsProvider>(context, listen: false)
                            .selected) {
                          Provider.of<TimeSlotsProvider>(context, listen: false)
                              .addSelectedToggledTimes();
                          print(Provider.of<TimeSlotsProvider>(context,
                                  listen: false)
                              .selectedTimes);
                          Provider.of<ProgressIndicatorProvider>(context,
                                  listen: false)
                              .currentPage = 5;
                          Provider.of<ProgressIndicatorProvider>(context,
                                  listen: false)
                              .updateProgress();
                        }
                      },
                      text: "Next"),
                ),
              ],
            ),
          ),
        ));
  }
}
