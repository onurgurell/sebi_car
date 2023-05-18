import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/login/widget/custom_text_field_area.dart';
import 'package:sebi_car/presentation/login/widget/email_and_create_account_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sebi Car'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Column(
        children: [
          _SignInWelcomeText(),
          CustomTextFieldArea(),
          EmailAndCreatAccountButton(),
        ],
      ),
    );
  }
}

class _SignInWelcomeText extends StatelessWidget {
  const _SignInWelcomeText();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: SizedBox(
        width: context.getDynmaicWidth(.9),
        height: context.getDynmaicHeight(.15),
        child: const Text(
          'Login to your account',
          style: TextStyle(fontSize: 38),
        ),
      ),
    );
  }
}
