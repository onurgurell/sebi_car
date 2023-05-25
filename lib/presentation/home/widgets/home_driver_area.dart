import 'package:flutter/material.dart';
import 'package:sebi_car/core/router/routes.dart';
import 'package:sebi_car/ui_kit/custom_divider.dart';
import 'package:sebi_car/ui_kit/base_button.dart';

class HomeDriverArea extends StatelessWidget {
  const HomeDriverArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomDivederArea(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            "Yolculuk Oluşturmak İster Misiniz?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: BaseButton(
            onTap: () {
              Navigator.pushNamed(context, Routes.journeyCreation);
            },
            title: 'Yolculuk Oluştur',
            icon: const Icon(
              Icons.travel_explore_rounded,
            ),
          ),
        ),
      ],
    );
  }
}
