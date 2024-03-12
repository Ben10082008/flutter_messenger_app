import "package:flutter/material.dart";
import "package:flutter_messenger_app/auth/auth_service.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  
  void logout(){
    final _auth = AuthService();
    _auth.signOut();
  }
  
  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
        //logout button
        IconButton(onPressed: logout, icon: Icon(Icons.logout))
      ],),
      
    );
  }
  }