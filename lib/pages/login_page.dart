import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_messenger_app/components/my_login_button.dart';
import 'package:flutter_messenger_app/services/auth/auth_service.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';
import 'package:flutter_messenger_app/pages/register_page.dart';


class LogInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  final void Function()? onTap;

  LogInPage({Key? key, required this.onTap});

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _pwController.text,
        _usernameController.text
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              const SizedBox(height: 50),
              Text(
                "Welcome back, its good to see you again!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
                ),
              ),
              const SizedBox(height: 25),
              
              
              MyLoginButton(
                text: "Login",
                onTap: () {
                  HapticFeedback.heavyImpact(); // Haptisches Feedback hinzufügen
                  login(context);
                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Register now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      themeMode: ThemeMode.light,
      theme: ThemeData.from(colorScheme: lightColorScheme),
      darkTheme: ThemeData.from(colorScheme: darkColorScheme),
    );
  }
}
