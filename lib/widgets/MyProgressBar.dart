import 'package:doneintern/provider/ProgressIndicatorProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProgessBar extends StatelessWidget{
  const MyProgessBar({super.key,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          Container(
            width: Provider.of<ProgressIndicatorProvider>(context).maxLength,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(35),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutQuad,
            width: Provider.of<ProgressIndicatorProvider>(context).progress,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(35),
            ),
          )
        ],
      ),
    );
  }

}