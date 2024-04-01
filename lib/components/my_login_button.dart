

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyLoginButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyLoginButton({
    super.key, 
    required this.text,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(15)

      
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      margin: const EdgeInsets.symmetric(horizontal: 70),
      child: Center(
        child: Text(
          "Login",
         style: TextStyle(
          fontSize: 20, 
          color: Theme.of(context).colorScheme.onBackground),
          ), 
          ),
        ),
    );
  }
}