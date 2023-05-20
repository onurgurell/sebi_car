import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class HomeText extends StatelessWidget {
  const HomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      width: context.getDynmaicWidth(.8),
      child: const Text(
        'Düşük Ücreteler Yolculuk Seçeneklerin',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
