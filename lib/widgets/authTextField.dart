import 'package:flutter/material.dart';
import 'package:rapid_medical_info_system/constants/constants.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {Key? key,
      this.labelText,
      this.obscureText,
      required this.controller,
      this.hintStyle,
      this.required = true,
      this.enabled = true,
      this.keyboardType, this.maxLines = 1, this.borderColor,
      })
      : super(key: key);
  final String? labelText;
  final bool? obscureText;
  final bool? required;
  final bool? enabled;
  final Color? borderColor;
  final int? maxLines;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        enabled: enabled,
        maxLines: maxLines,
        controller: controller,
        validator: (value) {

          if(required!){
            if (value!.isEmpty) {
              return "This Field is required";
            }
          }
          return null;
        },
        keyboardType: keyboardType ?? TextInputType.text,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
            hintText: labelText,
            hintStyle: hintStyle ?? TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: borderColor ?? Colors.white, width: 1)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: borderColor ?? Colors.white, width: 1))),
        obscureText: obscureText ?? false,
      ),
    );
  }
}
