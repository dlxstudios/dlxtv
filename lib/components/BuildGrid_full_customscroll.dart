import 'package:flutter/material.dart';
// import 'DLXGridItem.dart';
// import 'package:dlxtv/utils/tmdb_api.dart';
// import 'package:dlxtv/models/item_model.dart';
import 'package:dlxtv/utils/utils.dart';
import 'package:dlxtv/utils/assets.dart';

import 'dart:ui' as ui;

final double devicePixelRatio = ui.window.devicePixelRatio;

class BuildGrid extends StatelessWidget {
  final Function gridItemOnTap = (BuildContext context) {
    print('onTap from BuildGrid');
    return null;
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     // builder: (context) => DLXDetailMediaCollection(doc: doc),
    //   ),
    // );
  };

  BuildGrid();

  static Widget fromJsonAPI(
    BuildContext context,
    String url, [
    String itemsSelector,
    String titleVar,
    String posterVar,
    String gridRatio,
  ]) {
    // print('*** gridRatio ***');
    // print(gridRatio);
    double _gridRatio = 1.0;
    if (gridRatio != null) {
      _gridRatio = double.parse(gridRatio);
    }

    const iconSize = 50.0;
    Widget layout = LayoutBuilder(
        builder: (context, constraints) => Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Material(color: Colors.yellowAccent),
                Positioned(
                  top: 0.0,
                  child: Icon(Icons.star, size: iconSize),
                ),
                Positioned(
                  top: constraints.maxHeight - iconSize,
                  left: constraints.maxWidth - iconSize,
                  child: Icon(Icons.call, size: iconSize),
                ),
              ],
            ));

    return FutureBuilder(
        future: Utils.jsonFetchList(url, itemsSelector),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DataItem> items = snapshot.data;
            // print('mediaGrid.items.length : ' + items.length.toString());

            return LayoutBuilder(builder: (context, constraints) {
              print(
                  'constraints.maxWidth : ' + constraints.maxWidth.toString());
              print((constraints.maxWidth / 200).floorToDouble());
              print('devicePixelRatio : ' + devicePixelRatio.toString());
              // int gridCount = (constraints.maxWidth / 200).floor();
              int gridCount =
                  ((constraints.maxWidth * devicePixelRatio) / 200).floor();

              return CustomScrollView(
                primary: true,
                slivers: <Widget>[
                  SliverPadding(
                    padding: EdgeInsets.only(
                      // Mobile
                        // left: 16.0, top: 16.0, bottom: 16.0, right: 16.0),
                        // TV 720p
                        left: 8.0, top: 16.0, bottom: 0.0, right: 8.0),
                    sliver: SliverGrid.count(
                      crossAxisCount: gridCount,
                      // TV 720p
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      // Mobile
                      // crossAxisSpacing: 28.0,
                      // mainAxisSpacing: 16.0,
                      childAspectRatio: _gridRatio,
                      children: items.map(
                        (_item) {
                          String poster = Utils.stringVarMap(posterVar, _item);
                          String title = Utils.stringVarMap(titleVar, _item);
                          return Stack(children: [
                            Material(
                                color: Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                clipBehavior: Clip.antiAlias,
                                child: GridTile(
                                  footer: GridTileBar(
                                    title: Text(
                                      title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    backgroundColor: Colors.black12,
                                    // trailing: Icon(Icons.add_circle_outline),
                                  ),
                                  child: Stack(children: [
                                    FadeInImage.assetNetwork(
                                      placeholder:
                                          ImageAssets.posterPlaceholder,
                                      image: poster,
                                    ),
                                    Positioned.fill(
                                        child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        // child: Text('data'),
                                        onTap: () {},
                                      ),
                                    ))
                                  ]),
                                )),
                          ]);
                        },
                      ).toList(),
                    ),
                  ),
                ],
              );
            });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner
          return Container(
              child: Center(
            child: new CircularProgressIndicator(), // Loading...
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    print('** BuildGrid Build : ');

    return Container(
      child: Text('data'),
    );
  }
}

// CustomScrollView(
//               primary: true,
//               slivers: <Widget>[
//                 SliverPadding(
//                     padding: EdgeInsets.only(
//                         left: 16.0, top: 16.0, bottom: 16.0, right: 16.0),
//                     sliver: SliverGrid(
//                       gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                         childAspectRatio: _gridRatio,
//                         maxCrossAxisExtent: 197.0,
//                         mainAxisSpacing: 20.0,
//                         crossAxisSpacing: 16.0,
//                       ),
//                       delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                           var _item = items[index];
//                           // print('ITEM');
//                           // print(_item.data);
//                           String poster;
//                           if (posterVar!=null){
//                           poster = Utils.stringVarMap(posterVar, _item);
//                           }else{
//                             // poster = 'cover';
//                           }
//                           String title = Utils.stringVarMap(titleVar, _item);
//                           // return Text(title, style: Theme.of(context).textTheme.caption,);

//                           return DLXGridItem(
//                             title:title,
//                             poster: poster,
// //                             onTap: gridItemOnTap(_item),
//                           );
//                         },
//                         childCount: items.length,
//                       ),
//                     )),
//               ],
//             )
