import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class HomeSearchBaseTextField extends StatelessWidget {
  const HomeSearchBaseTextField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 22),
      width: context.getDynmaicWidth(.8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.location_searching),
        ),
      ),
    );
  }
}
