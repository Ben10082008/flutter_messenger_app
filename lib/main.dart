import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              //willkommen zurück nachricht

              const SizedBox(height: 50),

              Text(
                "Willkommen zurück, wir haben dich vermisst!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                  ),
                ),

              //Email text

              MyTextField(
                hintText: "Email",
                obscureText: false,
              ),

              const SizedBox(height: 25),

              //passwort text

              MyTextField(
                hintText: "Password",
                obscureText: true,
              ),


              //login button

              //register now
            ],
          )
        ),
      ),
    );
  }
}