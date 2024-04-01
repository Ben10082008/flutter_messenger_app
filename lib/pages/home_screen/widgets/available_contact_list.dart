import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/user_tile.dart';
import 'package:flutter_messenger_app/models/user.dart';

class AvailableContactList extends StatefulWidget {

  final List<User> contacts;

  const AvailableContactList({super.key, required this.contacts});

  @override
  State<AvailableContactList> createState() => _AvailableContactListState();
}

class _AvailableContactListState extends State<AvailableContactList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(),
      itemCount: widget.contacts.length,
      itemBuilder: (context, index) {
        return ContactUserTile(user: widget.contacts[index], onUserTap: () => debugPrint("User tapped"));
      },
    );
  }
}