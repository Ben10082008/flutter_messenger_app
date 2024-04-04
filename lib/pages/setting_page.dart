import "package:flutter/material.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage( {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color.fromARGB(249, 41, 41, 41),
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 167, 167, 167),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 25),
      ),
    );
  }
}