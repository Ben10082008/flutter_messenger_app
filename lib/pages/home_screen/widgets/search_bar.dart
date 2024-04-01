import 'package:flutter/material.dart';

class SearchBarCustom extends StatefulWidget {

  final Function onQueryCleared;
  final Function(String) onQueryEntered;
  final Function onTappedOutside;

  const SearchBarCustom({super.key, required this.onQueryCleared, required this.onQueryEntered, required this.onTappedOutside});

  @override
  State<SearchBarCustom> createState() => _SearchBarCustomState();
}

class _SearchBarCustomState extends State<SearchBarCustom> {

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

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
            hintText: "Suche einen Kontakt"
        ),
        onChanged: (value) { widget.onQueryEntered(value); },
        onTapOutside: (value) { focusNode.unfocus(); isUserSearching = false; widget.onTappedOutside(); },
        onSubmitted: (value) { focusNode.unfocus(); isUserSearching = false; },
        onEditingComplete: () { isUserSearching = false; },
        onTap: () => isUserSearching = true,
      ),
    );
  }
}