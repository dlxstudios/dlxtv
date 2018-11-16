import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dlxtv/components/DLXListItem.dart';
import 'package:dlxtv/models/item_model.dart';

class PageMediaDetail extends StatelessWidget {
  final String title;
  final Result item;

  PageMediaDetail({Key key, this.title = "Untitled", this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0.0,
            expandedHeight: 600.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(item.backdrop_path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Text(
                      item.title ?? this.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    item.release_date,
                    style: TextStyle(fontSize: 12.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              centerTitle: true,
            ),
//            backgroundColor: Colors.redAccent,
            pinned: true,
            actions: <Widget>[
              new IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Balance',
                onPressed: () {
                  /* ... */
                },
              ),
            ],
          ),
          SliverPadding(
            padding: EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 64.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                      // List<Widget> sections;
//
//                      sections.add(new Container(
//                        child: Text('data'),
//                      ));




                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Material(
                      elevation: 1.0,
                      color: Colors.tealAccent,
                      child: Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Text(
                          '$index Object',
                          style: TextStyle(fontSize: 32.0),
                        ),
                      ),
                    ),
                  );



                },
                childCount: 5,
              ),
            ),
          ),
//          Seasons(
//            doc: doc,
//          ),
        ],
      ),
    );
  }
}

class Seasons extends StatelessWidget {
  final DocumentSnapshot doc;

  Seasons({Key key, this.doc}) : super(key: key);

// doc.reference.collection("seasons").snapshots().length ??

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: doc.reference.collection("seasons").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
//            return const Text('loading...');
            return SliverToBoxAdapter();
          }
//
//          //print(snapshot.data.documents.length);
//
          if (snapshot.data.documents.length == 0) {
            return SliverToBoxAdapter();

//            return Container(
//              height: 0.0,
//              width: 0.0,
//            );
          }

          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 12.0),
                    child: Text(
                      'Section',
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    height: 200.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (_, index) {
//print(snapshot.data.documents[index].data.toString());
                        var item = snapshot.data.documents[index].data;

                        return Container(
                            width: 136.0,
                            child: Card(
                              color: Colors.deepPurpleAccent,
                              child: Image.network(item['poster']),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });

//      StreamBuilder(
//        stream: doc.reference.collection("seasons").snapshots(),
//        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//          if (!snapshot.hasData) {
//            return const Text('loading...');
//          }
//
//          //print(snapshot.data.documents.length);
//
//          if (snapshot.data.documents.length == 0) {
//            return Container(
//              height: 0.0,
//              width: 0.0,
//            );
//          }
//
//
//
//
//          return Card(
//            color: Colors.deepPurpleAccent,
//            child: DLXListItem(
//              poster: doc['poster'],
//              title: doc['name'],
//              // subtitle: doc['year']),
//            ),
//          );
//        });
  }
}
