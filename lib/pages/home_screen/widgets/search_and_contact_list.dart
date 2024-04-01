import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/models/user.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/available_contact_list.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/search_bar.dart';
import 'package:flutter_messenger_app/services/auth/chat/chat_service.dart';

class SearchAndContactList extends StatefulWidget {

  final bool onUserWillSearch;

  const SearchAndContactList({super.key, required this.onUserWillSearch});

  @override
  State<SearchAndContactList> createState() => _SearchAndContactListState();
}

class _SearchAndContactListState extends State<SearchAndContactList> {

  final ChatService chatService = ChatService();
  List<User> availableContatcs = List.empty(growable: true);


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if(!widget.onUserWillSearch || widget.onUserWillSearch) availableContatcs = List.empty(growable: true);
  
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // When user will search, show search bar only then
            widget.onUserWillSearch ? Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 2),
              child: SearchBarCustom(
                onQueryCleared: () => debugPrint(""),
                onQueryEntered: (query) {
                  setState(() {
                    availableContatcs = availableContatcs.where((user) => user.username.toUpperCase().contains(query.toUpperCase())).toList();
                  });
                },
                onTappedOutside: () => debugPrint(""),
              ),
            ) : const SizedBox(height: 0),

            // Show available contacts always
            StreamBuilder<QuerySnapshot<User>>(
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
                
                  return Flexible(child: AvailableContactList(contacts: availableContatcs));
                }
              }
            )
          ],
        ),
      ),
    );
  }
}