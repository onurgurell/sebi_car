import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/login/widget/custom_base_text_field.dart';
import 'package:sebi_car/ui_kit/custom_divider.dart';
import 'package:sebi_car/ui_kit/base_button.dart';
import 'package:sebi_car/ui_kit/error_or_success_dialog.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

Future<dynamic> signUpBottomSheet(BuildContext context) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Lütfen isim giriniz.';
    }
    if (value.length < 3) {
      return 'İsim 3 karakterden daha uzun olmalıdır.';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Lütfen e-mail adresi giriniz.';
    }
    if (!value.contains('@') || !value.endsWith('edu.tr')) {
      return 'Geçerli bir edu.tr e-mail adresi giriniz.';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Lütfen şifre giriniz.';
    }
    if (value.length <= 5) {
      return 'Şifre 5 karakterden daha uzun olmalıdır.';
    }
    return null;
  }

  return showModalBottomSheet(
    enableDrag: true,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          return Form(
            key: formKey,
            child: SizedBox(
              height: context.getDynmaicHeight(.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Create A New Account",
                    style: TextStyle(fontSize: 22),
                  ),
                  SizedBox(
                    height: context.getDynmaicHeight(.35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomBaseTextField(
                          validator: (value) => validateName(value!),
                          controller: viewModel.nameController,
                          hintText: 'Enter a name',
                          icon: Icons.person,
                        ),
                        CustomBaseTextField(
                          validator: (value) => validateEmail(value!),
                          controller: viewModel.emailController,
                          hintText: 'Enter e-mail',
                          icon: Icons.mail,
                        ),
                        CustomBaseTextField(
                          validator: (value) => validatePassword(value!),
                          controller: viewModel.passwordController,
                          hintText: 'Enter password',
                          icon: Icons.lock,
                        ),
                      ],
                    ),
                  ),
                  BaseButton(
                    title: 'Sign Up',
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          viewModel.saveUserInfo();

                          await viewModel.createEmailAndPassword();

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.purple,
                              content: Text('Doğrulama kodu gönderildi'),
                            ),
                          );

                          Navigator.of(context).pop();

                          viewModel.nameController.clear();
                          viewModel.emailController.clear();
                          viewModel.passwordController.clear();
                        } catch (e) {
                          showSuccessOrErrorDialog(
                              'Error', e.toString(), context);
                        }
                      }
                    },
                  ),
                  const CustomDivederArea(),
                  BaseButton(
                    title: 'Sign Up with Google',
                    onTap: () {
                      viewModel.signUpWithGoogle(context);
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
