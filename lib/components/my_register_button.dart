
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
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.secondary,

      
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      margin: const EdgeInsets.symmetric(horizontal: 70),
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