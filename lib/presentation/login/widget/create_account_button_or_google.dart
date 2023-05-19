import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/login/widget/create_account_bottom_sheet.dart';
import 'package:sebi_car/ui_kit/base_button.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class CreateAccountButtonOrGoogle extends StatelessWidget {
  const CreateAccountButtonOrGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        return SizedBox(
          height: context.getDynmaicHeight(.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseButton(
                onTap: () {
                  viewModel.signInWithGoogle(context);
                },
                title: 'Continue With Google',
                icon: const Icon(Icons.email),
              ),
              const SizedBox(height: 22),
              Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    signUpBottomSheet(context);
                  },
                  child: const Text("Don't have account? Create an account"),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
