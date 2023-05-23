import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/login/widget/custom_base_text_field.dart';
import 'package:sebi_car/ui_kit/custom_divider.dart';
import 'package:sebi_car/ui_kit/base_button.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class SignInTextFieldArea extends StatelessWidget {
  const SignInTextFieldArea({super.key});

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Lütfen şifre giriniz.';
    }
    if (value.length < 3) {
      return 'Şifre 3 karakterden daha uzun olmalıdır.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getDynmaicHeight(.4),
      child: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomBaseTextField(
                controller: viewModel.loginNameController,
                hintText: 'Enter Your Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 18),
              CustomBaseTextField(
                controller: viewModel.loginPasswordController,
                hintText: 'Enter password',
                icon: Icons.lock,
              ),
              const SizedBox(height: 18),
              BaseButton(
                title: 'Sign In',
                onTap: () {
                  viewModel.signInCheckEmailAndPassword(context);
                },
              ),
              const SizedBox(height: 22),
              const CustomDivederArea(),
            ],
          );
        },
      ),
    );
  }
}
