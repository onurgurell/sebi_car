import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class BaseSelectTimeOrCalender extends StatelessWidget {
  const BaseSelectTimeOrCalender({
    super.key,
    required this.title,
    required this.selectTime,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String selectTime;
  final IconData icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: context.getDynmaicWidth(.5),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Container(
          width: context.getDynmaicWidth(.4),
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(selectTime),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onTap,
                child: Icon(icon),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
