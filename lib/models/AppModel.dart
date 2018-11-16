import 'package:flutter/material.dart';

import 'package:dlxtv/models/BuildPage.dart';
// import 'package:dlxtv/pages/pageGrid.dart';

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
    Map<String, WidgetBuilder> _routes;
    for (int i = 0; i < appJson["routes"].length; i++) {
      BuildPage result = BuildPage.fromJson(context, appJson["routes"][i]);
      Map<String, dynamic> route = appJson["routes"][i];
      // BuildPageWidget result = BuildPageWidget(
        // path: result.path,
      // );
      // _routes.update("/"+result.path,  BuildPageWidget());
      // print('result.path');
      // print(result.path);
      // 'home' route
      if (result.path == "home") {
        // print('Home Page');
        // print(result.title);
        _home = result;
      }
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
        ListTile(
          leading: Icon(Icons.map),
          title: Text('Map'),
          onTap: () {
            Navigator.of(context).pushNamed('/map');
          },
        ),
        ListTile(
          leading: Icon(Icons.photo_album),
          title: Text('Album'),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
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

