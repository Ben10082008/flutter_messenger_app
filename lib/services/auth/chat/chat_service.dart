import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatService {

//get instace of firestore
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//get user stream

Stream<List<Map<String,dynamic>>> getUserStream() {
  return _firestore.collection("Users").snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final user = doc.data();
      debugPrint("User in db: $user");
      //return user
      return user;
    }).toList();
  });
}
//send messages

//get messages

}

