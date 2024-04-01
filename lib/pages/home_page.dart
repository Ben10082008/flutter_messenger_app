import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/components/user_tile.dart';
import 'package:flutter_messenger_app/pages/chat_page.dart';
import 'package:flutter_messenger_app/services/auth/auth_service.dart';
import 'package:flutter_messenger_app/components/my_drawer.dart';
import 'package:flutter_messenger_app/services/auth/chat/chat_service.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  bool _isSearchBarVisible = false;

  void _toggleSearchBarVisibility() {
    setState(() {
      _isSearchBarVisible = !_isSearchBarVisible;
    });
  }

  void _closeSearchBar() {
    setState(() {
      _isSearchBarVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color.fromARGB(249, 41, 41, 41),
        elevation: 0,
        foregroundColor: const Color.fromARGB(255, 167, 167, 167),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 25),
        actions: [
          IconButton(
            onPressed: _toggleSearchBarVisibility,
            icon: Icon(Icons.search),
            color: Colors.grey,
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: _isSearchBarVisible ? SearchBar(onClose: _closeSearchBar) : _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUserStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) =>
              _buildUserListItem(userData, context)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["uid"] != _authService.getCurrentUser()!.uid) {
      return UserTile(
        text: userData['username'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userData["email"],
                receiverID: userData["uid"],
                receiverNickname: userData['username'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

class SearchBar extends StatelessWidget {
  final VoidCallback onClose;

  const SearchBar({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: onClose, // Hier wird die onClose Funktion aufgerufen, um die Suchleiste zu schließen
          ),
        ),
      ),
    );
  }
}
