import 'package:flutter/material.dart';
import 'package:agile_tech/utils/gen/fonts.gen.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key, 
    this.borderColor, 
    this.fillColor, 
    this.maxLines, 
    required this.hintText, 
    required this.type, 
    this.validator, 
    required this.isPassword, 
    this.onChanged
  });

  final String hintText;
  final TextInputType type;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool isPassword;
  final Color? borderColor;
  final Color? fillColor;
  final bool? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines == true ? 1 : null,
      cursorColor: const Color(0xFF670F0F),
      autofocus: false,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      obscureText: isPassword,
      autovalidateMode: AutovalidateMode.disabled,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Color(0xFF670F0F), fontFamily: FontFamilyToken.montserrat, fontWeight: FontWeight.w500),
      keyboardType: type,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF670F0F), fontFamily: FontFamilyToken.montserrat, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: fillColor ?? const Color(0xFFFFE1E1),
        contentPadding: const EdgeInsets.only(
            left: 14, bottom: 6, top: 6),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF670F0F)),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        errorStyle: const TextStyle(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w400,
          fontFamily: FontFamilyToken.montserrat,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}