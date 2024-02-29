import 'package:doneintern/provider/timeslots_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTimeSlot extends StatelessWidget {
  final dynamic listItem;
  final Function onTap;

  const MyTimeSlot({super.key, required this.listItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Consumer<TimeSlotsProvider>(
        builder: (context, value, child) {
          //Check if one group is selected to set morning, afternoon or evening.
          bool toggled = false;
          if (listItem["String"] == "Morning" && value.zones[0]["Toggled"]) {
            toggled = true;
          } else if (listItem["String"] == "Afternoon" &&
              value.zones[1]["Toggled"]) {
            toggled = true;
          } else if (listItem["String"] == "Evening" &&
              value.zones[2]["Toggled"]) {
            toggled = true;
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: 104,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: listItem['Toggled'] || toggled
                  ? Colors.black
                  : Colors.grey.shade200,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  listItem['String'],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: listItem['Toggled'] ? Colors.white : Colors.black,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
