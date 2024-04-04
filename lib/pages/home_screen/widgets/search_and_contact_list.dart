import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/models/user.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/available_contact_list.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/search_bar.dart';

class SearchAndContactList extends StatefulWidget {
  const SearchAndContactList({
    required this.availableContacts,
    this.onUserWillSearch = false,
    super.key
    });

  final List<User> availableContacts;
  final bool onUserWillSearch;

  @override
  State<SearchAndContactList> createState() => _SearchAndContactListState();
}

class _SearchAndContactListState extends State<SearchAndContactList> {

  late List<User> availableContactList;
  late bool onUserWillSearch;

  @override
  void initState() {
    super.initState();
    availableContactList = widget.availableContacts;
    onUserWillSearch = widget.onUserWillSearch;
  }

  @override
  Widget build(BuildContext context) {

    if(!onUserWillSearch) availableContactList = widget.availableContacts;

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
                onQueryCleared: () {
                  onUserWillSearch = false;
                  setState(() {
                    availableContactList = widget.availableContacts;
                  });
                },
                onQueryEntered: (String query) {
                  debugPrint("----------------------------------------------");
                  onUserWillSearch = true;
                  setState(() {
                    availableContactList = availableContactList.where((user) => user.username.toUpperCase().contains(query.toUpperCase())).toList();
                  });
                },
                onTappedOutside: () {
                  setState(() {
                    onUserWillSearch = !onUserWillSearch;
                  });
                },
              ),
            ) : const SizedBox(height: 0),

            // Contact list
            Flexible(child: AvailableContactList(contacts: availableContactList))

          ],
        ),
      ),
    );
  }
}