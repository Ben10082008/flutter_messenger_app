import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/components/my_drawer.dart';
import 'package:flutter_messenger_app/pages/home_screen/widgets/search_and_contact_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isSearchFieldVisible = false;

  @override
  void initState() {
    super.initState();
    isSearchFieldVisible = false;
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
                isSearchFieldVisible = !isSearchFieldVisible;
              }),
              icon: const Icon(Icons.search),
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: SearchAndContactList(
          onUserWillSearch: isSearchFieldVisible,
        ),
      )
    );
  }
}

