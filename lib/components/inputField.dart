import 'package:flutter/material.dart';

import '../constants.dart';

class InputField extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final Function onChanged;
  final bool obscureText;
  InputField(
      {this.hintText = '',
      this.keyboardType,
      this.obscureText = false,
      @required this.onChanged});

  @override
  TextField build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
    );
  }
}
