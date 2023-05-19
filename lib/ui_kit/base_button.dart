import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.title,
    this.icon,
    required this.onTap,
  });
  final String title;
  final Icon? icon;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              context.getDynmaicWidth(.6),
              context.getDynmaicHeight(.05),
            ),
          ),
          onPressed: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon ?? const SizedBox(),
              const SizedBox(width: 2),
              // viewModel.isLoading
              //     ? const SizedBox(
              //         width: 22,
              //         height: 22,
              //         child: CircularProgressIndicator(),
              //       )
              //     :
              Text(title)
            ],
          ),
        );
      },
    );
  }
}
