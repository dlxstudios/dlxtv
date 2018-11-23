import 'package:flutter/material.dart';
// import 'DLXGridItem.dart';
// import 'package:dlxtv/utils/tmdb_api.dart';
// import 'package:dlxtv/models/item_model.dart';
import 'package:dlxtv/utils/utils.dart';
import 'package:dlxtv/utils/assets.dart';

import 'dart:ui' as ui;
import 'dart:typed_data';

final double devicePixelRatio = ui.window.devicePixelRatio;

class BuildGrid extends StatelessWidget {
  BuildGrid();

  String itemsUrl;
  String itemsSelector;
  String titleVar;
  String posterVar;
  double gridRatio = 1.0;
  
  _poster(String src) {
    return FadeInImage(
        image: new NetworkImage(src),
        placeholder: new AssetImage(ImageAssets.posterPlaceholder));
  }

  BuildGrid.fromJson(BuildContext context, Map<String, dynamic> compJson) {
    // Check for 'itemsUrl'
    // print(route['MediaGrid']['itemsUrl']);

    Map<String, dynamic> mg = compJson['MediaGrid'];

    if (mg.containsKey('itemsUrl')) {
      itemsUrl = mg['itemsUrl'];
      if (mg.containsKey('itemsSelector') != null) {
        itemsSelector = mg['itemsSelector'];
      }

      if (mg.containsKey('poster')) {
        // print(route['MediaGrid']['poster']);
        posterVar = mg['poster'];
      }

      if (mg.containsKey('title')) {
        // print("route['MediaGrid']['title']");
        // print(route['MediaGrid']['title']);
        titleVar = mg['title'];
      }

      if (mg.containsKey('gridRatio')) {
        // print('gridRatio '+mg['gridRatio']);
        gridRatio = double.parse(mg['gridRatio'] ?? 1.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print('** BuildGrid Build : ');

    return FutureBuilder(
        future: Utils.jsonFetchList(itemsUrl, itemsSelector),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<DataItem> items = snapshot.data;
            // print('mediaGrid.items.length : ' + items.length.toString());

            return SliverPadding(
              padding: EdgeInsets.only(
                  // Mobile
                  // left: 16.0, top: 16.0, bottom: 16.0, right: 16.0),
                  // TV 720p
                  left: 8.0,
                  top: 16.0,
                  bottom: 0.0,
                  right: 8.0),
              sliver: SliverGrid.count(
                crossAxisCount: 2,
                // TV 720p
                crossAxisSpacing: 20.0,
                // mainAxisSpacing: 8.0,
                // Mobile
                // crossAxisSpacing: 28.0,
                // mainAxisSpacing: 16.0,
                childAspectRatio: gridRatio,
                children: items.map(
                  (_item) {
                    String poster = Utils.stringVarMap(posterVar, _item);
                    // String title = Utils.stringVarMap(titleVar, _item);

                    return Stack(children: [
                      Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          clipBehavior: Clip.antiAlias,
                          child: GridTile(
                            // footer: GridTileBar(
                            //   title: Text(
                            //     title,
                            //     maxLines: 2,
                            //     overflow: TextOverflow.ellipsis,
                            //   ),
                            //   backgroundColor: Colors.black45,
                            //   // trailing: Icon(Icons.add_circle_outline),
                            // ),

                            // child: Image.asset(ImageAssets.posterPlaceholder),
                            child: Stack(children: [
                              // _poster(poster),
                              FadeInImage(
                                  image: new NetworkImage(poster),
                                  placeholder: new AssetImage(
                                      ImageAssets.posterPlaceholder)),
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
            );
          } else if (snapshot.hasError) {
            return SliverToBoxAdapter(
              child: Text("${snapshot.error}"),
            );
          }

          // By default, show a loading spinner

          return SliverToBoxAdapter(
              child: Container(
                  child: Center(
            child: new CircularProgressIndicator(), // Loading...
          )));
        });
  }
}
