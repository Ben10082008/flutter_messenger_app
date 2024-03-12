import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/auth/auth_service.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_button.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';





class RegisterPage extends StatelessWidget {

  //Email und Passwort Controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpw = TextEditingController();


  final void Function()? onTap;
 


  RegisterPage({super.key, required this.onTap});

  
  //regsiter method
  void register(BuildContext context) {
    final _auth = AuthService();

    //password moatch -> create user

    if (_pwController.text == _confirmpw.text) {
      try {
      _auth.signUpWithEmailPassword(
      _emailController.text,
       _pwController.text);
      }catch (e) {
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
        title: Text(e.toString())
        )
        );
      }
    }
    //password dont match -> tell user to fix

    else {
      showDialog(
        context: context,
        builder: (context) =>const AlertDialog(
        title: Text ("Passwords don't match!"),
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
                "Lass uns deinen ersten account erstellen!",
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

              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _pwController,
              ),


              const SizedBox(height: 25),

              //passwort text

              MyTextField(
                hintText: "Confirm Password",
                obscureText: true,
                controller: _confirmpw,
              ),

              const SizedBox(height: 25),


              //login button
              
              MyButton(
                text: "Login",
                onTap: () => register(context),
              ),

              const SizedBox(height: 25),

              //register now
              Row(
                mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground
                    ),
                    
                
                  ),
                  GestureDetector(    
                    onTap: onTap,        
                  child: Text("Login now",
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