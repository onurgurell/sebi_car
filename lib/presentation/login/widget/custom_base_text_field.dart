import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class CustomBaseTextField extends StatelessWidget {
  const CustomBaseTextField({
    super.key,
    required this.hintText,
    required this.icon,
  });

  final String hintText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getDynmaicWidth(.9),
      height: 60,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(22.0),
          ),
        ),
      ),
    );
  }
}
