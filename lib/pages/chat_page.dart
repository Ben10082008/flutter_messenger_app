

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_expandable_fab/flutter_expandable_fab.dart";
import "package:flutter_messenger_app/components/chat_bubble.dart";
import "package:flutter_messenger_app/components/expandable_fab.dart";
import "package:flutter_messenger_app/components/my_textfield.dart";
import "package:flutter_messenger_app/services/auth/auth_service.dart";
import "package:flutter_messenger_app/services/auth/chat/chat_service.dart";
import "package:flutter_speed_dial/flutter_speed_dial.dart";

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  final String receiverNickname;
  
  
  ChatPage( {
    super.key,
    required this.receiverEmail, 
    required this.receiverID,
    required this.receiverNickname,
    
    });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text conttroller
  final TextEditingController _messageController = TextEditingController();

  //chat & auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //for textfield focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    //add listener to focus node

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        //cause a delay so that the keyboard has time to show up
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    }
    );

    // wait a bit for listview to built  then scroll down
    Future.delayed(const Duration(milliseconds: 500),
    () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent, 
      duration: const Duration(seconds: 1), 
      curve: Curves.fastOutSlowIn,

      );
  }




  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverID, _messageController.text);

      //clear text controller

      _messageController.clear();
    }

    scrollDown();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: const ExpandableFabPantryMaster(
      ),
      
      floatingActionButtonLocation: ExpandableFab.location,
      
      
      
      
              

     
      backgroundColor: Theme.of(context).colorScheme.onTertiary,
      appBar: AppBar(
        title: Text(
          widget.receiverNickname.toUpperCase()
          ),
      backgroundColor: const Color.fromARGB(250, 43, 42, 42),
      elevation: 0,
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      centerTitle: true,
  

      
      ),
      body: Column(children: [

        //display all messages
        Expanded(child: _buildMessageList(),
        
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 75),
          child: _buildUserInput(),
        )

        //user input

      ],
      ),
    );


  }

    //build message list
    Widget _buildMessageList() {
      String senderID = _authService.getCurrentUser()!.uid;
      return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID), 
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
            controller: _scrollController,
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
//build message input
Widget _buildUserInput() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12.0),
    child: Row(
      children: [
        //textfield should take up most of the space
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: MyTextField(
              borderRadius: 25,
              controller: _messageController, 
              hintText: "Type a message",
              obscureText: false,
              focusNode: myFocusNode,
              suffixIcon: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.green,
                  
                ),
                iconSize: 30,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

    
}