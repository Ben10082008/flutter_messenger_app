import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/services/auth/auth_gate.dart';
import 'package:flutter_messenger_app/services/auth/login_or_register.dart';
import 'package:flutter_messenger_app/color_schemes.g.dart';
import 'package:flutter_messenger_app/components/my_textfield.dart';
import 'package:flutter_messenger_app/firebase_options.dart';
import 'package:flutter_messenger_app/pages/login_page.dart';
import 'package:flutter_messenger_app/pages/register_page.dart';





void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: const AuthGate(),
        themeMode: ThemeMode.light,
        theme: ThemeData.from(colorScheme: lightColorScheme),
        darkTheme: ThemeData.from(colorScheme: darkColorScheme),
    );
  }
}