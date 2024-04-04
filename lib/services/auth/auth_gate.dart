import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_messenger_app/services/auth/login_or_register.dart";
import 'package:flutter_messenger_app/pages/home_screen/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  
  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        }

        //user not logged in

        else {
          return const LoginOrRegister();
        }
      },
      ),
    );
  }  
}