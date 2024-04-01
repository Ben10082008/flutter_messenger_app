import "package:flutter/material.dart";
import "package:flutter/rendering.dart";

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({super.key, 
  required this.text, 
  required this.onTap
  });


  @override
  Widget build (BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(12),
        
        ),
        margin: const EdgeInsets.symmetric(vertical: 25,  horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            //Icon

            const Icon(Icons.person, size: 30,),

            const Padding(
              padding: EdgeInsets.only(right: 15)
              ),

            //Username

            Text(
              text, 
            style: const TextStyle(
              fontSize: 18),),
            
          ],
        ),
      ),
    );
  }  
}