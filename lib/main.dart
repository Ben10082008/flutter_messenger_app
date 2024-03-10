import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_button.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';
import 'package:flutter_messenger_app/themes/lightmode.dart';




void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //Email und Passwort Controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
 





  MyApp({super.key});

  //login method
  void login() {
    
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor:Theme.of(context).colorScheme.background,

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.onBackground,
              ),

              //willkommen zurück nachricht

              const SizedBox(height: 50),

              Text(
                "Willkommen zurück, wir haben dich vermisst!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
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
                onTap: login,
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
                  Text("Register now",
                    style: TextStyle(fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                
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