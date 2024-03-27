import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_messenger_app/components/chat_bubble.dart";
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: Text(receiverEmail),
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.grey,
  

      
      ),
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

      //is current user

      bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;


      // align message to right if sender is the current user

      var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;


      return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser)
          ],
        ));
    }

    //build message input
    Widget _buildUserInput() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Row(
          children: [
            //textfield should take up most of the space
            Expanded(
              child: MyTextField(
              controller: _messageController, 
              hintText: "Type a message",
               
              obscureText: false,
              ),
              
            ),
        
            //send button
            Container(
              decoration: const BoxDecoration(
                color: Colors.green,
              shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.arrow_upward,
                  color: Colors.white,
                  ),
              ),
            ),
          ],
        ),
      );
    }

}