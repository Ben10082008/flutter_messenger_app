import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_messenger_app/components/my_textfield.dart";
import "package:flutter_messenger_app/services/auth/auth_service.dart";
import "package:flutter_messenger_app/services/auth/chat/chat_service.dart";

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  
  ChatPage({
    super.key,
    required this.receiverEmail, 
    required this.receiverID
    
    });

  //text conttroller

  final TextEditingController _messageController = TextEditingController();

  //chat & auth services

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      //clear text controller

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(receiverEmail)),
      body: Column(children: [

        //display all messages
        Expanded(child: _buildMessageList(),
        
        ),

        _buildUserInput(),

        //user input

      ],
      ),
    );


  }
    //build message list

    Widget _buildMessageList() {
      String senderID = _authService.getCurrentUser()!.uid;
      return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID), 
        builder: (context, snapshot) {

          //errors
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("loading..");
          }

          //return list view

          return ListView(
            children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          );

      },
      );
    }

    //build message item
    Widget _buildMessageItem(DocumentSnapshot doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return Text(data["message"]);
    }

    //build message input
    Widget _buildUserInput() {
      return Row(
        children: [
          //textfield should take up most of the space
          Expanded
          (child: MyTextField(
            controller: _messageController, 
            hintText: "Type a message", 
            obscureText: false,
            )
          ),

          //send button
          IconButton(
            onPressed: sendMessage, 
            icon: const Icon(Icons.arrow_upward),
          ),
        ],
      );
    }

}