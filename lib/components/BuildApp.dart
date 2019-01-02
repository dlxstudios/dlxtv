import 'package:flutter/material.dart';
import 'package:dlxtv/models/BuildPage.dart';
// import 'package:dlxtv/pages/pageGrid.dart';
import 'package:device_info/device_info.dart';

class BuildApp extends StatefulWidget {
  String title;
  Widget home;
  Map<String, dynamic> appJson;
  Map<String, BuildPage> routes = {};
  BuildApp({Key key, this.title, this.home, this.appJson, this.routes})
      : super(key: key);

  @override
  _BuildAppState createState() => _BuildAppState.fromJson(this.appJson);
}

class _BuildAppState extends State<BuildApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static const int kTabletBreakpoint = 600;
  String title;
  Widget home;
  Map<String, dynamic> appJson;
  Map<String, BuildPage> routes = {};
  String _selectedItem = '/home';
  // BuildPage _selectedPage;

  _BuildAppState({Key key, this.title, this.home, this.appJson, routes});

  _BuildAppState.fromJson(Map<String, dynamic> appJson) {
    if (appJson.containsKey('title')) title = appJson["title"] ?? "App title";

    if (appJson.containsKey('routes')) {
      // Get the all the routes
      for (int i = 0; i < appJson["routes"].length; i++) {
        BuildPage page = BuildPage.fromJson(appJson["routes"][i]);
        // if (page.path == "/homeSC") {
        //   home = page;
        //   // _selectedItem = page.path;
        //   // _selectedPage = page;
        // }
        // Add page to routes Map
        routes.putIfAbsent(page.path, () => page);
      }
    }
  }

  Widget _drawer() {
    return Material(
      child: MenuList(
        routes: routes,
        itemSelectedCallback: (item) {
          print(this);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              maintainState: false,
              builder: (BuildContext context) {
                return Scaffold(
                  drawer: _drawer(),
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(item.title),
                  ),
                  body: SafeArea(
                    child: item,
                  ),
                );
                // return item;
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          primary: true,
          title: Text(routes[_selectedItem].title),
        ),
        body: routes[_selectedItem],
        drawer: _drawer());
  }

  Widget _buildTabletLayout() {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          child: Material(
            color: Colors.transparent,
            child: MenuList(
              routes: routes,
              itemSelectedCallback: (item) {
                setState(() {
                  _selectedItem = item.path;
                  // _selectedPage = item;
                });
              },
              selectedItem: _selectedItem,
            ),
          ),
        ),
        Flexible(
            flex: 8,
            // child: _selectedPage,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Material(
                  elevation: 4.0,
                  color: Colors.deepPurple,
                  // shape: BeveledRectangleBorder(
                  //   borderRadius:
                  //       BorderRadius.only(topLeft: Radius.circular(46.0)),
                  // ),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 0.0, left: 0.0, right: 0.0, bottom: 0.0),
                      child: Container(
                        child: routes.containsKey(_selectedItem)
                            ? routes[_selectedItem]
                            : Container(
                                child: Center(
                                  child:
                                      Text('No route found : $_selectedItem'),
                                ),
                              ),
                      ))),
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('## Build APP ##');
    // print(MediaQuery.of(context).devicePixelRatio);
    // print(MediaQuery.of(context).size.longestSide);
    // if (widget.appJson != null) {
    //   fromJson();
    // }

    // print('_selectedItem');
    // print(_selectedItem);

    Widget content;
    var shortestSide = MediaQuery.of(context).size.longestSide /
        MediaQuery.of(context).devicePixelRatio;
    // var shortestSide = MediaQuery.of(context).size.shortestSide;
    // var shortestSide = 700.0;

    if (shortestSide < kTabletBreakpoint) {
      content = _buildMobileLayout();
    } else {
      content = _buildTabletLayout();
    }

    return content;
  }
}

class Item {
  Item({
    @required this.title,
    @required this.subtitle,
  });

  final String title;
  final String subtitle;
}

class MenuList extends StatelessWidget {
  final Map<String, BuildPage> routes;

  MenuList({
    @required this.itemSelectedCallback,
    this.selectedItem,
    this.routes,
  });

  final ValueChanged<BuildPage> itemSelectedCallback;
  final String selectedItem;

  @override
  Widget build(BuildContext context) {
    // print('routes');

    // print(routes);

    if (routes == null) {
      return Container(
          child: SizedBox.expand(
        child: Center(
          child: Text("No 'routes' in app config"),
        ),
      ));
    }

    List<Widget> tiles = [];

    // tiles.add(
    //   DrawerHeader(
    //     child: Container(
    //       height: 30,
    //       child: Image(
    //         image: AssetImage('assets/mario.png'),
    //         fit: BoxFit.contain,
    //       ),
    //     ),
    //   ),
    // );

    routes.forEach((path, page) {
      tiles.add(ListTile(
        title: Text(page.title),
        onTap: () => itemSelectedCallback(page),
        selected: selectedItem == path,
      ));
    });

    return Container(
        // constraints: BoxConstraints(maxHeight: 450.0, minHeight: 150.0),
        // alignment: Alignment.center,
        // color: Colors.amber,
        width: 250.0,
        child: Column(
          children: <Widget>[
            Flexible(
              child: DrawerHeader(
                child: Container(
                  height: 30,
                  child: Image(
                    image: AssetImage('assets/mario.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Flexible(
              child: ListView(
                children: tiles,
              ),
            )
          ],
        ));
  }
}
