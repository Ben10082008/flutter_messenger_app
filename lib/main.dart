import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/auth/login_or_register.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_button.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';
import 'package:flutter_messenger_app/pages/login_page.dart';
import 'package:flutter_messenger_app/pages/register_page.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: LoginOrRegister(),
        themeMode: ThemeMode.light,
        theme: ThemeData.from(colorScheme: lightColorScheme),
        darkTheme: ThemeData.from(colorScheme: darkColorScheme),
    );
  }
}