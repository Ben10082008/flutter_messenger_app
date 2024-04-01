import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String uid;

  User({
    required this.email,
    required this.username,
    required this.uid,
  });

  //convert to a map

  Map<String, dynamic> toMap() {
    return {
      'email' : email,
      'username' : username,
      'uid' : uid,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email' : email,
      'username' : username,
      'uid' : uid,
    };
  }

  factory User.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();

    return User(
      email: data?['email'],
      username: data?['username'],
      uid: data?['uid'],
    );
  }
}