import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/pages/login_page.dart';
import 'package:flutter_messenger_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegister();
}

class _LoginOrRegister extends State<LoginOrRegister> {


  //show login page

  bool showLoginPage = true;

  //zwischen login und register hin und her togglen

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LogInPage(
        onTap: togglePages,
      );
    }else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}