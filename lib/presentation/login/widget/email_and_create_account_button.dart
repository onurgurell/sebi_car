import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/login/widget/custom_base_text_field.dart';
import 'package:sebi_car/presentation/login/widget/custom_divider.dart';
import 'package:sebi_car/ui_kit/base_button.dart';

class EmailAndCreatAccountButton extends StatelessWidget {
  const EmailAndCreatAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getDynmaicHeight(.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BaseButton(
            title: 'Continue With Google',
            icon: Icon(Icons.email),
          ),
          const SizedBox(height: 22),
          Container(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                _signUpBottomSheet(context);
              },
              child: const Text("Don't have account? Create an account"),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> _signUpBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SizedBox(
          height: context.getDynmaicHeight(.6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Create A New Account",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: context.getDynmaicHeight(.3),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBaseTextField(
                      hintText: 'Enter a name',
                      icon: Icons.person,
                    ),
                    CustomBaseTextField(
                      hintText: 'Enter e-mail',
                      icon: Icons.mail,
                    ),
                    CustomBaseTextField(
                      hintText: 'Enter password',
                      icon: Icons.lock,
                    ),
                  ],
                ),
              ),
              const BaseButton(title: 'Sign Up'),
              const CustomDivederArea(),
              const BaseButton(title: 'Sign Up with Google'),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
