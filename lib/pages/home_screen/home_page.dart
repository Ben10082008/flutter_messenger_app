import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/models/user.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/search_and_contact_list_container.dart';
import 'package:flutter_messenger_app/services/auth/chat/chat_service.dart';


class HomeScreen extends StatelessWidget {

  bool isSearchFieldVisible = false;

  final ChatService chatService = ChatService();

  List<User> availableContatcs = List.empty(growable: true);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot<User>>(
      stream: chatService.getUserStream(), 
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          // No data available
          return const Center(child: Text("Fehler"),);
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Lade"),);
        } else {
          snapshot.data?.docs.forEach((element){
            availableContatcs.add(element.data());
          });

          return SearchAndContactListContainer(
            contactList: availableContatcs,
          );
        }
      }
    );
  }
}

