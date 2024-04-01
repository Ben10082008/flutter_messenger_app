import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/models/user.dart';

class ContactUserTile extends StatelessWidget {

  final User user;
  final Function onUserTap;

  const ContactUserTile({super.key, required this.user, required this.onUserTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUserTap(),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 25,  horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.person, size: 30,),

            Text(
              user.username, 
              style: const TextStyle(
                fontSize: 18
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}