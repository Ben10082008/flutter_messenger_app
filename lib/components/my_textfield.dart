import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final double borderRadius;


  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    this.focusNode,
    this.suffixIcon,
    this.borderRadius = 10
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      focusNode: focusNode,
      cursorColor: const Color.fromARGB(255, 87, 87, 87),
      decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.shadow),
        borderRadius: BorderRadius.circular(borderRadius)
      ),
      fillColor: Theme.of(context).colorScheme.onTertiary,
      filled: true,
      hintText: hintText,
      suffixIcon: suffixIcon,
      hintStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }
}