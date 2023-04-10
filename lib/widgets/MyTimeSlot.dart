import 'package:doneintern/provider/TimeSlotsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTimeSlot extends StatelessWidget {
  final dynamic listItem;
  final Function onTap;

  MyTimeSlot({super.key, required this.listItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Consumer<TimeSlotsProvider>(
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOutQuad,
            width: 104,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: listItem['Toggled'] ? Colors.black : Colors.grey.shade200,
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
                    overflow: TextOverflow.ellipsis
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
