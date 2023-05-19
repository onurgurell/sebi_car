import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class CustomBaseTextField extends StatelessWidget {
  const CustomBaseTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
  });
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return SizedBox(
      width: context.getDynmaicWidth(.9),
      child: TextFormField(
        obscureText:
            hintText == 'Enter password' ? viewModel.isPasswordObscure : false,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: hintText == 'Enter password'
              ? InkWell(
                  onTap: () {
                    viewModel.changeObscureText();
                  },
                  child: viewModel.isPasswordObscure
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                )
              : const SizedBox(),
          hintText: hintText,
          prefixIcon: Icon(icon),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.black,
            ), //<-- SEE HERE
            borderRadius: BorderRadius.circular(22.0),
          ),
        ),
      ),
    );
  }
}
