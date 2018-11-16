import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlxtv/models/item_model.dart';



class DLXListView extends StatefulWidget {

    final List<Result> items;

  DLXListView({Key key, this.items});

  @override
  _DLXListViewState createState() => _DLXListViewState();
}

class _DLXListViewState extends State<DLXListView> {
   List<Result> items;
_DLXListViewState({Key key, this.items});

  @override
  Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: 0,
  //     itemExtent: 200.0,
  //     padding: EdgeInsets.all(16.0),
  //     itemBuilder: (BuildContext context, int index) {
  //       if(index == 0 ){
  //         return Text('No Items'); 
  //       }
  //       print('ListView index : ' + index.toString());
  //       return Text(index.toString());
  //     },
  //   );

  return Text(this.items.toString());
  }

}

Widget listItemBuilder(BuildContext context, DocumentSnapshot doc) {
//    const String name = 'name';

  return Card(
    child: Column(
//        mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          leading: Container(
            constraints: BoxConstraints.expand(width: 136.0, height: 200.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: NetworkImage(doc['cover'] ?? ''))),
            ),
          ),
          title: Text(doc['name'] ?? '<Untitled>'),
//              subtitle: Text(doc['season_count'] >1 'season' ??),
        ),
        ButtonTheme.bar(
          // make buttons use the appropriate styles for cards
          child: ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {
                  /* ... */
                },
              ),
              RaisedButton(
                color: Colors.orange,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.play_arrow, color: Colors.white),
                    Text('PLAY', style: TextStyle(color: Colors.white)),
                  ],
                ),
                onPressed: () {
                  print("channel selected: " + doc['cover']);
                },
              )
            ],
          ),
        ),
      ],
    ),
  );
//        Text(doc['name']),
//
}

////////////////////////////////////////////
Widget dlxMediaListItem(BuildContext context, DocumentSnapshot doc) {
  var thumb = Container(
//      color: Colors.orange,
      height: 150.0,
      width: 102.0,
      child: Image.network(
        doc['poster'] ??
            'https://github.com/flutter/website/blob/master/src/_includes/code/layout/lakes/images/lake.jpg?raw=true',
      ));

  var detail = Expanded(
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
//          height: 150.0,
//          width: 100.0,
//          color: Colors.deepPurpleAccent,
        alignment: FractionalOffset.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
//          mainAxisAlignment: MainAxisAlignment.end,

          children: <Widget>[
            Text(doc['name'] ?? '<Untitled>',
                style: Theme.of(context).textTheme.title),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                doc['description'] ?? '<No description>',
                style: Theme.of(context).textTheme.body1,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    ),
  );

  var buttons = Container();

  return Card(
    elevation: 1.0,
    color: Colors.black26,
    child: Stack(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[thumb, detail, buttons],
      ),
      Positioned.fill(
          child: new Material(
              color: Colors.transparent,
              child: new InkWell(
                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => ChannelPage(doc: doc),
//                    ),
//                  );
//                  print("clicked " + doc['name']);
                },
              ))),
    ]),
  );
}
