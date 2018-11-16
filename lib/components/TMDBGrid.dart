import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dlxtv/components/BuildGridItem.dart';
import 'package:dlxtv/utils/tmdb_api.dart';
import 'package:dlxtv/models/item_model.dart';

class DLXGrid extends StatelessWidget {
  final Function gridItemOnTap = (DocumentSnapshot doc) {
    print('onTap from DLXGrid' + doc['name']);
// return null;
    //  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => DLXDetailMediaCollection(doc: doc),
//                    ),
//                  );
  };


  @override
  Widget build(BuildContext context) {
    print('** DLXGrid Build : ');

    return FutureBuilder(
        future: TMDBAPI.getPopular(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ItemModel item = snapshot.data;

            return CustomScrollView(
              primary: true,
              slivers: <Widget>[
                SliverPadding(
                    padding:
                        EdgeInsets.only(left: 16.0, top: 16.0, bottom: 72.0),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 0.68,
                        maxCrossAxisExtent: 197.0,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 0.0,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var _item = item.results[index];

                          return DLXGridItem(
                            title: _item.title,
                            poster: _item.poster_path,
                            item: _item,
//                             onTap: gridItemOnTap(_item),
                          );
                        },
                        childCount: item.results.length,
                      ),
                    )),
              ],
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return CircularProgressIndicator();
        });
  }
}
