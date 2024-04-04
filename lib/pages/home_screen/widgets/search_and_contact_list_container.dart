import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/components/my_drawer.dart';
import 'package:flutter_messenger_app/models/user.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/search_and_contact_list.dart';
import 'package:flutter_messenger_app/services/auth/chat/chat_service.dart';

class SearchAndContactListContainer extends StatefulWidget {

  const SearchAndContactListContainer({super.key, required this.contactList});

  final List<User> contactList;

  @override
  State<SearchAndContactListContainer> createState() => _SearchAndContactListContainerState();
}

class _SearchAndContactListContainerState extends State<SearchAndContactListContainer> {
  
  final ChatService chatService = ChatService();

  List<User> contactList = <User>[];

  bool isSearchBarVisible = false;

  @override
  void initState() {
    super.initState();
    contactList = widget.contactList;
    isSearchBarVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          actions: [
            IconButton(
              onPressed: () => setState(() {
                isSearchBarVisible = !isSearchBarVisible;
              }),
              icon: const Icon(Icons.search),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: SearchAndContactList(
          onUserWillSearch: isSearchBarVisible, 
          availableContacts: contactList
        ),
      )
    );
  }
}