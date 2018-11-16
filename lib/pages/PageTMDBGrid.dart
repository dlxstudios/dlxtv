import 'package:flutter/material.dart';
//
import 'package:dlxtv/components/TMDBGrid.dart';
import 'package:dlxtv/pages/PageSearch.dart';

class PageGrid1 extends StatelessWidget {
  void _toggleSearch() {}

  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      centerTitle: true,
      elevation: 0.0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Text('Channels'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // TMDBAPI.getSearch();
            _toggleSearch();
          },
        )
      ],
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {
//        TMDBAPI.getMovie('335983');
          }),
      backgroundColor: Theme.of(context).primaryColor,
      appBar: appBar,
      body: DLXGrid(),
    );
  }
}

class PageGrid extends StatefulWidget {
  List items;
  String title;

  PageGrid({Key key, List items, String title="Grid"}) : super(key: key);

  @override
  _PageGridState createState() => _PageGridState();
}

class _PageGridState extends State<PageGrid> {

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      centerTitle: true,
      elevation: 2.0,
      leading: IconButton( 
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            // TMDBAPI.getSearch();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PageSearch(),
              ),
            );
          },
        )
      ],
    );

    return Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
//        TMDBAPI.getMovie('335983');
            }),
        backgroundColor: Theme.of(context).primaryColor,
        appBar: appBar,
        body: DLXGrid());
  }
}
