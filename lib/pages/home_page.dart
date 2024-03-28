import "package:flutter/material.dart";
import "package:flutter_messenger_app/components/user_tile.dart";
import "package:flutter_messenger_app/pages/chat_page.dart";
import "package:flutter_messenger_app/services/auth/auth_service.dart";
import "package:flutter_messenger_app/components/my_drawer.dart";
import "package:flutter_messenger_app/services/auth/chat/chat_service.dart";


class Homepage extends StatelessWidget {
  
 Homepage({super.key});

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  

  

  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: 
        Text("Home"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey,

        
        
        
      
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),

      
    );
  }


  Widget _buildUserList(){
      return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading..");
          }

          //return listView
          return ListView(
            children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData, context)).toList(),
          );
        },
      );

  }

  //build individual list title for user

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    //display all user except current user

    if (userData["email"] != _authService.getCurrentUser()!.email) {
    
    return UserTile(
    text: userData['email'],
    onTap: () {
      //when tapped -> ChatPage
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(
        receiverEmail: userData["email"],
        receiverID: userData["uid"],
      ),
      )
      );
    },
    );
  }else {
    return Container();
  }
  }
      
  }

