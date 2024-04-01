import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';


class ExpandableFabPantryMaster extends StatefulWidget {


  const ExpandableFabPantryMaster({super.key});

  @override
  State<ExpandableFabPantryMaster> createState() => _ExpandableFabPantryMasterState();
}

class _ExpandableFabPantryMasterState extends State<ExpandableFabPantryMaster> {

  final _methods = ['photo', 'link', 'audio'];
  final _icons = [Icons.camera_alt_outlined, Icons.link, Icons.mic];

  String action = 'Choose a method';




  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.add),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        shape: const CircleBorder(),
      
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: Theme.of(context).colorScheme.background,
        backgroundColor: Theme.of(context).colorScheme.shadow,
        shape: const CircleBorder(),
      ),
      duration: const Duration(milliseconds: 400),
      type: ExpandableFabType.up,
      distance: 70.0,
      children: List.generate(_methods.length, (index) {
        return FloatingActionButton.small(
          elevation: 80,
          backgroundColor: Theme.of(context).colorScheme.outline,
          tooltip: _methods[index],
          onPressed: () => setState(() {
            action = _methods[index];
            _handleMethod(context, action);
          }),
          child: Icon(
            _icons[index],
            color: Theme.of(context).colorScheme.scrim,
          ),
        );
      }),
    );
  }

  Future<void> _handleMethod(BuildContext context, String method) async {
    switch (method) {
      case "photo":
        
        break;
      case "link":
     
        break;
      case "audio":

        break;
    }
  }
}