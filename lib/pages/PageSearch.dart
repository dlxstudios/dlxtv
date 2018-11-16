import 'package:flutter/material.dart';
import 'package:dlxtv/components/DLXListView.dart';
import 'package:dlxtv/models/item_model.dart';
class PageSearch extends StatefulWidget {
  @override
  _PageSearchState createState() => _PageSearchState();
}

class _PageSearchState extends State<PageSearch> {
  static TextEditingController _controllerSearch = TextEditingController();
  final FocusNode myFocusNode = FocusNode();
  List<Result> items;

  Widget _appBar = AppBar(
    title: TextField(
      // focusNode: myFocusNode,
      autofocus: true,
      controller: _controllerSearch,
      decoration: InputDecoration(
        hintText: 'Movie, Actor, TV Show',
      ),
    ),
  );

  _printLatestValue() {
    print("Text field: ${_controllerSearch.text}");
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes
    _controllerSearch.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    // myFocusNode.dispose();
    // _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _appBar,
      body: DLXListView(items: items,),
    );
  }
}
