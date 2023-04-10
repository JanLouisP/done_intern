import 'package:doneintern/provider/TimeSlotsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyElevatedButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const MyElevatedButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 5000),
      curve: Curves.easeInOutQuad,
      width: 335,
      height: 48,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Provider.of<TimeSlotsProvider>(context).selected
              ? Colors.black
              : Colors.grey.shade200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(text, style: TextStyle(
          color:Provider.of<TimeSlotsProvider>(context).selected
              ? Colors.white
              : Colors.black,
        ),),
      ),
    );
  }
}
