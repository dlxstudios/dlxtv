import 'package:flutter/material.dart';

import 'package:dlxtv/models/BuildPage.dart';
// import 'package:dlxtv/pages/pageGrid.dart';

import 'package:dlxtv/utils/theme.dart';

class BuildApp extends StatefulWidget {
  final String title;
  final Widget home;
  final Map<String, dynamic> appJson;

  BuildApp({Key key, this.title = "My New App", this.home, this.appJson})
      : super(key: key);

  @override
  _BuildAppState createState() => _BuildAppState();
}

class _BuildAppState extends State<BuildApp> {
  String _title = "App";
  String get title => _title;

  PageRoute _home;

  Map<String, dynamic> appJson;

  fromJson(BuildContext context, Map<String, dynamic> appJson) {
    // Get the title
    // print(appJson["title"]);
    _title = appJson["title"] ?? "App title";
    // 'home' route
    // BuildPage _home;

    // Get the all the routes
    for (int i = 0; i < appJson["routes"].length; i++) {
      PageRoute page = PageRoute.fromJson(appJson["routes"][i]);

      if (page.path == "home") {
        print(page.title);
        _home = page;
      }
    }
  }

  Widget list(BuildContext context) {
    return ListView(
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
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.appJson);
    if (widget.appJson != null) {
      fromJson(context, widget.appJson);
    }

    return MaterialApp(
        // routes: _routes,

        debugShowCheckedModeBanner: false,
        title: title,
        theme: darkTheme,
        // onGenerateRoute: findRoute,
        home: Scaffold(
            backgroundColor: Colors.teal,
            body: Container(
                child: Row(
              children: <Widget>[
                Flexible(
                  child: list(context),
                  flex: 2,
                ),
                Flexible(
                  // color: Colors.red,
                  child: _home.build(),
                  flex: 8,
                ),
              ],
            )))
        // home: _home.build(context),
        // home: PageGrid(title: title,)
        );
  }
}

class PageRoute {
  String title;
  String path;

  PageRoute.fromJson(Map<String, dynamic> parsedJson) {
    this.title = parsedJson['title'];
    this.path = parsedJson['path'];
  }
  build(){
    return BuildPageWidget(path: path, title: title,);
  }
}
