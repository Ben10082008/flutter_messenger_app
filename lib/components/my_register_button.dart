
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyRegisterButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const MyRegisterButton({
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

      
      ),
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: Text(
          "Register",
         style: TextStyle(
          fontSize: 20, 
          color: Theme.of(context).colorScheme.onBackground),
          ), 
          ),
        ),
    );
  }
}