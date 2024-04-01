import 'package:flutter/material.dart';


class SearchField extends StatefulWidget {

  final Function(String) onQueryEntered;
  final Function onQueryCleared;

  const SearchField({super.key, required this.onQueryEntered, required this.onQueryCleared});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {



  // TextEditing-controller
  final TextEditingController textEditingController = TextEditingController();

  // Focus Node
  final FocusNode focusNode = FocusNode();

  // Is Field focused
  bool isUserSearching = false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 70,
      child: TextField(
        controller: textEditingController,
        obscureText: false,
        focusNode: focusNode,
        decoration: InputDecoration(
            suffixIcon: isUserSearching ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() { textEditingController.text = ""; });
                widget.onQueryCleared();
              },
            ) : null,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 0.5)
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onBackground, width: 0.5)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.errorContainer)
            ),
            hintText: "Suche einen Artikel"
        ),
        onChanged: (value) { widget.onQueryEntered(value); },
        onTapOutside: (value) { focusNode.unfocus(); isUserSearching = false; widget.onQueryCleared(); },
        onSubmitted: (value) { focusNode.unfocus(); isUserSearching = false; },
        onEditingComplete: () { isUserSearching = false; },
        onTap: () => isUserSearching = true,
      ),
    );
  }
}