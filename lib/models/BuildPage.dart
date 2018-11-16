import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:convert';

import 'package:dlxtv/components/BuildGrid.dart';

class BuildPage {
  BuildContext _context;
  String _type = "home";
  String get type => type;
  String _title = "Page";
  String _path;
  String itemsUrl;
  String itemsSelector;
  String titleVar;
  String posterVar;
  String gridRatio;

  BuildPage(
    this._title,
  );

  BuildPage.fromJson(BuildContext context, Map<String, dynamic> route) {
    // Set the BuildContext
    _context = context;
    // print('BuildPage.fromJson');
    // print(route['title']);
    _title = route['title'] ?? 'Untitled';
    // print(_path);
    _path = route['path'] ?? '';
    _type = route['type'] ?? '';
    // print('type');
    // print(_type);
    // Check if 'MediaGrid'
    if (_type == "MediaGrid") {
      // Check for 'itemsUrl'
      // print(route['MediaGrid']['itemsUrl']);
      if (route['MediaGrid']['itemsUrl'] != null) {
        itemsUrl = route['MediaGrid']['itemsUrl'];
        if (route['MediaGrid']['itemsSelector'] != null) {
          itemsSelector = route['MediaGrid']['itemsSelector'];
        }

        if (route['MediaGrid']['poster'] != null) {
          // print(route['MediaGrid']['poster']);
          posterVar = route['MediaGrid']['poster'];
        }

        if (route['MediaGrid']['title'] != null) {
          // print("route['MediaGrid']['title']");
          // print(route['MediaGrid']['title']);
          titleVar = route['MediaGrid']['title'];
        }

        if (route['MediaGrid']['gridRatio'] != null) {
          // print('gridRatio '+route['MediaGrid']['gridRatio']);
          gridRatio = route['MediaGrid']['gridRatio'];
        }

        // jsonFetchList(route['MediaGrid']['itemsUrl'],
        //         route['MediaGrid']['itemsSelector'])
        //     .then((list) {
        //   // print('[MediaGrid][itemsUrl], itemsSelector');
        //   // print(list.length);
        //   items = list;
        // });

        // items = jsonFetchList(route['MediaGrid']['itemsUrl'],
        //         route['MediaGrid']['itemsSelector']);
      }
    }
  }

  Widget build(BuildContext context) {
    // print('BuildPage.build  type');
    // print(_type);

    if (_type == "MediaGrid" && itemsUrl != null) {
      // print('Type == #MediaGrid');
      return BuildGrid.fromJsonAPI(context, itemsUrl, itemsSelector ?? null,
          titleVar ?? null, posterVar ?? null, gridRatio);
    }

    // Widget _mediaGrid = Container(child:Text(itemsUrl));

    // return _mediaGrid;

    return Container(
      color: Colors.lightBlue,
      child: Text(
        _title,
        style: Theme.of(_context).textTheme.body1,
      ),
    );
  }

  // Properties
  String get title => _title;
  String get path => _path;
}

class BuildPageWidget extends StatelessWidget {
   String title = "new skool";
   String path = "/";
    Map<String, dynamic> json;

  BuildPageWidget({Key key, title, path}) : super(key: key);
  // BuildPageWidget.fromJson({Key key, this.json}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo,
      child: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
    );
  }
}
