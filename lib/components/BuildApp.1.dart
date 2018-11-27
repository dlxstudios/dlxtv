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
  static const int kTabletBreakpoint = 600;

  String _title = "App";
  String get title => _title;


  Widget _selectedPage;

  Map<String, dynamic> appJson;

  Map<String, WidgetBuilder> _routes = {};
  List<Widget> _menuItems = [];

  fromJson(BuildContext context, Map<String, dynamic> appJson) {
    // Get the title
    // print(appJson["title"]);
    _title = appJson["title"] ?? "App title";
    // 'home' route
    // BuildPage _home;

    // Get the all the routes
    for (int i = 0; i < appJson["routes"].length; i++) {
      BuildPage page = BuildPage.fromJson(appJson["routes"][i]);

      if (page.path == "/home") {
  
        _selectedPage = page;
      }
      // Add page to routes Map
      _routes.putIfAbsent(page.path, () => (BuildContext context) => page);
      // Add page to menu List
      // _menuItems.add(MenuItem(
      //     itemSelectedCallback: (page) {
      //       setState(() {
      //         // _selectedPage = page;
      //         // print(_selectedPage.toString());
      //       });
      //     },
      //     selectedItem: _selectedPage,
      //     page: page));
      // _menuItems.add(MenuItem(page.title, page.path));
      // <String, WidgetBuilder>{
      //     "/home": (BuildContext context) => _home
      //   }

    }
  }

  Widget _menu(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     DrawerHeader(
    //       child: Container(
    //         height: 30,
    //         child: Image(
    //           image: AssetImage('assets/mario.png'),
    //           fit: BoxFit.contain,
    //         ),
    //       ),
    //     ),

    //   ],
    // );

 
    return Material(
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: _menuItems.length,
        itemBuilder: (BuildContext context, int index) {
          return _menuItems[index];
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.appJson);
    if (widget.appJson != null) {
      fromJson(context, widget.appJson);
    }

    print('_routes.length : ${_routes.length}');

    return MaterialApp(
        // routes: _routes,
        debugShowCheckedModeBanner: false,
        title: title,
        theme: darkTheme,
        // onGenerateRoute: findRoute,
        home: Container(
            color: Colors.deepOrangeAccent,
            child: Row(
              children: <Widget>[
                Flexible(
                  // child: _menu(context),
                  child: Container(
                    // color: Colors.yellow,
                    child: SizedBox.expand(
                      child: DrawerMenu(routes: _routes,),
                    ),

                    // child: Text('data'),
                  ),

                  flex: 2,
                ),

                Flexible(
                  flex: 8,
                  child: SizedBox.expand(
                    child: Container(
                      child: Material(
                        elevation: 30.0,
                        shape: BeveledRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(46.0)),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(top: 46.0),
                            child: Container(
                              child: Container(
                                child: _selectedPage,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
                // Flexible(
                //   // color: Colors.red,
                //   child: _home,
                //   flex: 8,
                // ),
              ],
            ))
        // home: _home.build(context),
        // home: PageGrid(title: title,)
        );
  }
}

// MaterialApp(
//         routes: _routes,
//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: darkTheme,
//         // onGenerateRoute: findRoute,
//         home: Scaffold(
//             // backgroundColor: Colors.teal,
//             body: Container(
//                 child: Row(
//           children: <Widget>[
//             Flexible(
//               child: _menu(context),
//               flex: 2,
//             ),
//             Flexible(
//               // color: Colors.red,
//               child: _home,
//               flex: 8,
//             ),
//           ],
//         )))
//         // home: _home.build(context),
//         // home: PageGrid(title: title,)
//         );

class DrawerMenu extends StatefulWidget {
  final List items;
  Map<String, WidgetBuilder> routes;
  DrawerMenu({this.items, this.routes});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  List items;
  Map<String, WidgetBuilder> routes;




  @override
  Widget build(BuildContext context) {


    items.insert(
      0,
      DrawerHeader(
        child: Container(
          height: 30,
          child: Image(
            image: AssetImage('assets/mario.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (BuildContext context, int index) {
          // return MenuItem(page: );
        },
      ),
    );

  }
}

class MenuItem extends StatelessWidget {
  String title = '';
  String path = '';
  final ValueChanged<Widget> itemSelectedCallback;
  final Widget selectedItem;
  final Widget page;

  // MenuItem(this.title, this.path);
  MenuItem({@required this.itemSelectedCallback, this.selectedItem, this.page});

  @override
  Widget build(BuildContext context) {
    // print(' Menu Item ${this.title}');
    return ListTile(
      leading: Icon(Icons.whatshot),
      // title: Text(page.title),
      onTap: () => itemSelectedCallback(this),
      selected: selectedItem == this,
    );
  }
}

// class BuildAppX extends StatefulWidget {
//   String _title = "App";
//   String get title => _title;
//   // Pages
//   BuildPage _home;
//   Widget get home => _home;

//   List<Widget> _pages;
//   List<Widget> get pages => _pages;

//   Map<String, dynamic> _appJson;
//   Map<String, dynamic> get appJson => _appJson;

//   BuildAppX(
//       {Key key,
//       String title,
//       List<Widget> pages,
//       Widget home,
//       Map<String, dynamic> appJson});

//   @override
//   _BuildAppState createState() =>
//       _BuildAppState(this.title, this.pages, this.home, this.appJson);
// }

// class _BuildAppState extends State<BuildApp> {
//   String _title = "App";
//   String get title => _title;
//   // Pages
//   BuildPage _home;
//   Widget get home => _home;

//   List<Widget> _pages;
//   List<Widget> get pages => _pages;

//   Map<String, dynamic> _appJson;
//   Map<String, dynamic> get appJson => _appJson;

//   _BuildAppState(title, pages, home, appJson);

//   _BuildAppState.fromJson(BuildContext context, Map<String, dynamic> appJson) {
//     // Get the title
//     // print(appJson["title"]);
//     var _title = appJson["title"] ?? "App title";

//     // Get the all the routes
//     Map<String, WidgetBuilder> _routes;
//     for (int i = 0; i < appJson["routes"].length; i++) {
//       BuildPage _page = BuildPage.fromJson(appJson["routes"][i]);
//       if (_page.path == "home") {
//         _home = _page;
//       }
//     }
//   }

//   findRoute(RouteSettings rs) {
//     print('RouteSettings : ' + rs.name);
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget list = ListView(
//       children: <Widget>[
//         DrawerHeader(
//           child: Container(
//             height: 30,
//             child: Image(
//               image: AssetImage('assets/mario.png'),
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         ListTile(
//           leading: Icon(Icons.map),
//           title: Text('Map'),
//           onTap: () {
//             Navigator.of(context).pushNamed('/map');
//           },
//         ),
//         ListTile(
//           leading: Icon(Icons.photo_album),
//           title: Text('Album'),
//         ),
//         ListTile(
//           leading: Icon(Icons.phone),
//           title: Text('Phone'),
//         ),
//       ],
//     );

//     return MaterialApp(
//         // routes: _routes,

//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: darkTheme,
//         onGenerateRoute: findRoute,
//         home: Scaffold(
//             backgroundColor: Colors.teal,
//             body: Container(
//                 child: Row(
//               children: <Widget>[
//                 Flexible(
//                   child: list,
//                   flex: 2,
//                 ),
//                 Flexible(
//                   child: _home.build(context),
//                   flex: 8,
//                 ),
//               ],
//             )))
//         // home: _home.build(context),
//         // home: PageGrid(title: title,)
//         );
//   }
// }
