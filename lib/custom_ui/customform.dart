import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomForm extends StatelessWidget {
  void Function(String)? onChanged;
  TextInputType? keyboardType;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextEditingController? controller;
  bool obscureText;
  String? hintText;
  String? Function(String?)? validator;
  CustomForm({super.key, this.hintText,this.controller, this.onChanged, this.prefixIcon,this.keyboardType,this.suffixIcon,this.validator,this.obscureText=false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ,
      validator: validator,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: prefixIcon,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
