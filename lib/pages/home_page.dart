import "package:flutter/material.dart";
import "package:flutter_messenger_app/auth/auth_service.dart";
import "package:flutter_messenger_app/components/my_drawer.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  

  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      
      ),
      drawer: MyDrawer(),

      
    );
  }
  }