// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_messenger_app/services/auth/auth_service.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_button.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';
import 'package:flutter_messenger_app/pages/register_page.dart';






class LogInPage extends StatelessWidget {

  //Email und Passwort Controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // tap to register page

  final void Function()? onTap;

  LogInPage({super.key, required this.onTap});
 






  //login method
  void login(BuildContext context) async {
    //auth service

    final authService= AuthService();
    try {
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text,);
    }
    
    //catch errors

    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: Text(e.toString()),
      )
      );
    }
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor:Theme.of(context).colorScheme.primary,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.onPrimary,
              ),

              //willkommen zurück nachricht

              const SizedBox(height: 50),

              Text(
                "Willkommen zurück, wir haben dich vermisst!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  ),
                ),

              //Email text

              const SizedBox(height: 10),

              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 25),

              //passwort text

              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),

              const SizedBox(height: 25),


              //login button
              
              MyButton(
                text: "Login",
                onTap: () => login(context)
                
                
              // ignore: prefer_const_constructors
              ), 
            
              const SizedBox(height: 25),

              //register now
              Row(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Text("Not a member?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground
                    ),
                    
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text("Register now",
                      style: TextStyle(fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                
                     ),
                     ),
                ],       
              ),
            ],
          )
        ),
      ),
      themeMode: ThemeMode.light,
      theme: ThemeData.from(colorScheme: lightColorScheme),
      darkTheme: ThemeData.from(colorScheme: darkColorScheme),
    );
  }
}