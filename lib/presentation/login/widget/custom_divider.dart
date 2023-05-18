import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class CustomDivederArea extends StatelessWidget {
  const CustomDivederArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.black,
          width: context.getDynmaicWidth(.4),
          height: .2,
        ),
        Container(
          alignment: Alignment.center,
          width: context.getDynmaicWidth(.2),
          child: const Text('Or'),
        ),
        Container(
          color: Colors.black,
          width: context.getDynmaicWidth(.4),
          height: .2,
        ),
      ],
    );
  }
}
