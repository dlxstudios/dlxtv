import 'package:flutter/material.dart';
import 'package:dlxtv/models/item_model.dart';
import 'package:dlxtv/pages/pageMediaDetail.dart';
import 'package:dlxtv/utils/assets.dart';

class DLXGridItem extends StatelessWidget {
  final String title;
  final Result item;

//  final DocumentSnapshot doc;
//  final VoidCallback onTap;
  final String poster;

  DLXGridItem({Key key, this.title, this.poster, this.item}) : super(key: key);

  void _navigateItemDetail(
    BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PageMediaDetail(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
//    print('DLXGridItem build: ' + title ?? '');
    // print("DLXGridItem build : poster");
    // print(this.poster);

    // var _hero = Hero(
    //   tag: doc.documentID,
    //   child: _full,
    // );

    return Container(
      // color: Colors.red,
      child: Center(
//                             child: DLXGridItem(
//                               title: title,
//                               poster: poster,
// //                             onTap: gridItemOnTap(_item),
//                             ),
        child: Column(children: [
          Flexible(
              flex: 9,
              child: Material(
                  // borderRadius: BorderRadius.all(
                  //     Radius.circular(10.0)),
                  // clipBehavior: Clip.antiAlias,
                  child: FadeInImage.assetNetwork(
                placeholder: ImageAssets.posterPlaceholder,
                image: poster,
              ))),
          Flexible(
              // flex: 1,
              child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead,
              maxLines: 2,
            ),
          ))
        ]),
      ),
    );
  }
}

class GridPoster extends StatelessWidget {
  final String poster;
  GridPoster(this.poster) : super();

  @override
  Widget build(BuildContext context) {
    if (poster != null) {
      try {
        return FadeInImage.assetNetwork(
          placeholder: ImageAssets.posterPlaceholder,
          image: poster,
        );
      } catch (e) {
        return Text(e.toString());
      }
    } else {
      return SizedBox.expand(
        child: Expanded(
          child: Image(
            image: AssetImage(ImageAssets.posterPlaceholder),
            fit: BoxFit.fill,
          ),
        ),
      );
    }

    // return Text('rr');
  }
}

