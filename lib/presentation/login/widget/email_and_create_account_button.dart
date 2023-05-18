import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';
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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      child: Column(
                        children: [
                          Container(),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text("Don't have account? Create an account"),
            ),
          )
        ],
      ),
    );
  }
}
