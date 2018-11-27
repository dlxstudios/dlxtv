import 'package:flutter/material.dart';
import 'package:dlxtv/utils/utils.dart';

class BuildList extends StatelessWidget {
  String _itemsUrl;
  String _itemsSelector;

  String _posterVar;
  String _titleVar;
  bool fromJson;

  final Map<String, dynamic> compJson;

  BuildList(this.compJson);

  BuildList.fromJson(this.compJson) {
    print('_itemsUrl : ' + compJson.toString());

    if (compJson.containsKey('List') != true) {
      fromJson = false;
    }

    fromJson = true;
    Map<String, dynamic> _listJson = compJson['List'];

    if (_listJson.containsKey('itemsUrl')) {
      _itemsUrl = _listJson['itemsUrl'];
      if (_listJson.containsKey('itemsSelector') != null) {
        _itemsSelector = _listJson['itemsSelector'];
      }

      if (_listJson.containsKey('poster')) {
        // print(route['MediaGrid']['poster']);
        _posterVar = _listJson['poster'];
      }

      if (_listJson.containsKey('title')) {
        // print("route['MediaGrid']['title']");
        // print(route['MediaGrid']['title']);
        _titleVar = _listJson['title'];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int width = (MediaQuery.of(context).size.longestSide /
            MediaQuery.of(context).devicePixelRatio)
        .floor();
    int gridCrossAxisCount = (width / 200).floor();
    print('fromJson : $fromJson');

    if (fromJson == false) {
      return SliverToBoxAdapter(
          child: Container(
              child: Center(
        child: new CircularProgressIndicator(), // Loading...
      )));
    }

    return FutureBuilder(
        future: Utils.jsonFetchList(_itemsUrl, _itemsSelector),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<dynamic> items = snapshot.data;
            // print('List.items.length : ${items.length}');

            return SliverToBoxAdapter(
              child: Container(
                // margin: EdgeInsets.all(8.0),
                // color: Colors.deepOrange,
                height: 120.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding:
                        EdgeInsets.symmetric(
                          // horizontal: 16.0,
                           vertical: 10.0
                           ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (items.length == 0) {
                        return Text('no items');
                      }
                      // var video = artist.videos[index];
                      // return VideoCard(video);

                      String poster =
                          Utils.stringVarMap(_posterVar, items[index]);
                      String title =
                          Utils.stringVarMap(_titleVar, items[index]);

                      return Container(
                          margin: EdgeInsets.symmetric(horizontal: 12.0),
                          child: Material(
                            // elevation: 4.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(children: <Widget>[
                                Container(
                                  width: 190.0,
                                  decoration: BoxDecoration(
                                    color: Colors.black45,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(poster)),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {},
                                    ),
                                  ),
                                )
                              ])
                              
                              ));
                    }),
              ),
            );
          }

          if (snapshot.error != null) {
            return SliverToBoxAdapter(
              child: Text("Error : ${snapshot.error}"),
            );
          }

          return SliverToBoxAdapter(
              child: Container(
            child: SizedBox(
              width: 200.0,
              height: 160.0,
              child: Center(
                child: Text("Loading"),
              ),
            ),
          ));
        });
  }
}




// Text(
//   '$title',
//  maxLines: 1,
//  overflow: TextOverflow.ellipsis,
//  style: Theme.of(context).textTheme.caption,
//  textAlign: TextAlign.left,
//  ),