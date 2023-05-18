import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    required this.title,
    this.icon,
  });
  final String title;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          context.getDynmaicWidth(.6),
          context.getDynmaicHeight(.05),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon ?? const SizedBox(),
          const SizedBox(width: 2),
          Text(title),
        ],
      ),
    );
  }
}
