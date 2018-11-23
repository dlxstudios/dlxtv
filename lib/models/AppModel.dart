import 'package:flutter/material.dart';

import 'package:dlxtv/models/BuildPage.dart';


import 'package:dlxtv/utils/theme.dart';

class AppModel {
  // Set the App 'title'
  String _title = "App";
  String get title => _title;
  // Set the 'routes' (routes)
  // List<BuildPage> _routes;

  // Map<String, WidgetBuilder> get routes => _routes;

  // Widget _home;

  static Widget fromJson(BuildContext context, Map<String, dynamic> appJson) {
    // Get the title
    // print(appJson["title"]);
    var title = appJson["title"] ?? "App title";
    // 'home' route
    BuildPage _home;

    // Get the all the routes
    List menu = [];
    for (int i = 0; i < appJson["routes"].length; i++) {
      BuildPage _page = BuildPage.fromJson(appJson["routes"][i]);
      // Map<String, dynamic> route = appJson["routes"][i];
      
      if (_page.path == "home") {
        // print('Home Page');
        // print(_page.title);
        _home = _page;
      }

      menu.add({"title": _page.title, "path": _page.path});


    }

    Widget list = ListView(
      children: <Widget>[
        DrawerHeader(
          child: Container(
            height: 30,
            child: Image(
              image: AssetImage('assets/mario.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),

        
      ],
    );

    findRoute(RouteSettings rs) {
      print('RouteSettings : ' + rs.name);
    }

    return MaterialApp(
        // routes: _routes,

        debugShowCheckedModeBanner: false,
        title: title,
        theme: darkTheme,
        onGenerateRoute: findRoute,
        home: Scaffold(
            backgroundColor: Colors.teal,
            body: Container(
                child: Row(
              children: <Widget>[
                Flexible(
                  child: list,
                  flex: 2,
                ),
                Flexible(
                  child: _home.build(context),
                  flex: 8,
                ),
              ],
            )))
        // home: _home.build(context),
        // home: PageGrid(title: title,)
        );

    //  PageGrid(title: title,)
  }
}

