import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dlxtv/pages/pageMediaDetail.dart';
import 'package:dlxtv/components/DLXListView.dart';

class DLXMediaHomeList extends StatelessWidget {
  final _routes = <String, WidgetBuilder>{
    "channelPage": (BuildContext context) => new PageMediaDetail()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DLX TV',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'DLX TV'),
      routes: _routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('channels').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('loading...');
            }

//            Return ListView
            return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    dlxMediaListItem(context, snapshot.data.documents[index]));
          }),
    );
  }
}

//
//child: Column(
//children: <Widget>[
//Container(
////      color: Colors.orange,
//height: 150.0,
//width: 102.0,
//child: Image.network(
//doc['cover'] ??
//'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
//)),
//Text(doc['description']),
//],
//),
