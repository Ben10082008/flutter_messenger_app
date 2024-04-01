import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_messenger_app/components/my_register_button.dart';
import 'package:flutter_messenger_app/services/auth/auth_service.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';





class RegisterPage extends StatelessWidget {

  //Email und Passwort Controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpw = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();


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
       _pwController.text,
       _usernameController.text);
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
                "Let's create your first account!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  ),
                ),

              //Email text

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MyTextField(
                  hintText: "Username", 
                  obscureText: false, 
                  controller: _usernameController,
                  
                  ),
              ),

              const SizedBox(height: 25),

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

              //passwort text

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: _confirmpw,
                ),
              ),

              const SizedBox(height: 25),


              //login button
              
              MyRegisterButton(
                text: "Register",
                onTap: (){
                  HapticFeedback.heavyImpact();
                 register(context);
                }
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