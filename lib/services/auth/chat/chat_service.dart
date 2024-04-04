import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_messenger_app/models/message.dart';
import 'package:flutter_messenger_app/models/user.dart' as messageUser;

class ChatService {

//get instace of firestore
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;


//get user stream

Stream<QuerySnapshot<messageUser.User>> getUserStream() {
  return _firestore
      .collection("Users")
      .withConverter(fromFirestore: messageUser.User.fromFirestore, toFirestore: (messageUser.User user, _) => user.toFirestore())
      .snapshots(includeMetadataChanges: false);
}
//send messages


  Future<void> sendMessage(String receiverID, message) async {

    //get current user info
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message

    Message newMessage = Message(
      senderID : currentUserID,
      senderEmail : currentUserEmail,
      receiverID : receiverID,
      message : message,
      timestamp : timestamp
    );

    //construct chat room ID for the two users

    List<String> ids = [currentUserID, receiverID];
    ids.sort(); //sort the ids (this ensure the ChatroomID is the same for any 2 people)
    String ChatroomID = ids.join('_');

    //add new message to database
    await _firestore.collection("chat_rooms").doc(ChatroomID).collection("messages").add(newMessage.toMap());


    
}


//get messages
  Stream<QuerySnapshot> getMessages(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String ChatroomID = ids.join('_');

    return _firestore.collection("chat_rooms").doc(ChatroomID).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }

}

