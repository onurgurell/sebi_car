import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class BaseContainerForDriverInfo extends StatelessWidget {
  const BaseContainerForDriverInfo({
    super.key,
    required this.hintText,
    required this.title,
    this.suffixIcon,
    required this.controller,
  });

  final String hintText;
  final String title;
  final Widget? suffixIcon;
  final TextEditingController controller;
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
        SizedBox(
          width: context.getDynmaicWidth(.4),
          height: 40,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              hintText: hintText,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                ), //<-- SEE HERE
                borderRadius: BorderRadius.circular(30.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.black,
                ), //<-- SEE HERE
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: Container(
                width: context.getDynmaicWidth(.1),
                height: 22,
                padding: const EdgeInsets.only(right: 12),
                alignment: Alignment.centerRight,
                child: suffixIcon,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
