import 'package:doneintern/widgets/MyTimeSlot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/TimeSlotsProvider.dart';

class MyGridView extends StatelessWidget {
  final List<dynamic> elements;
  final String listName;

  const MyGridView({super.key, required this.elements, required this.listName});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: elements.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        childAspectRatio: 104 / 48,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return MyTimeSlot(
          listItem: elements[index],
          onTap: () {
            //If listName == Zones, then a full zone needs to be toggled.
            if (listName == "Zones") {
              elements[index]["Toggled"] = !elements[index]["Toggled"];
              Provider.of<TimeSlotsProvider>(context, listen: false)
                  .toggleTimeSlotGroup(elements[index]["String"]);
            } else {
              Provider.of<TimeSlotsProvider>(context, listen: false)
                  .toggleSingleTimeSlot(index, listName);
            }
          },
        );
      },
    );
  }
}
