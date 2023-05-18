import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/login/widget/custom_base_text_field.dart';
import 'package:sebi_car/presentation/login/widget/custom_divider.dart';
import 'package:sebi_car/ui_kit/base_button.dart';

class CustomTextFieldArea extends StatelessWidget {
  const CustomTextFieldArea({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getDynmaicHeight(.4),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomBaseTextField(
            hintText: 'Enter Your Email',
            icon: Icons.email,
          ),
          SizedBox(height: 18),
          CustomBaseTextField(
            hintText: 'Enter Your password',
            icon: Icons.lock,
          ),
          SizedBox(height: 18),
          BaseButton(title: 'Sign In'),
          SizedBox(height: 22),
          CustomDivederArea(),
        ],
      ),
    );
  }
}
