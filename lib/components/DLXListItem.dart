import 'package:flutter/material.dart';

class DLXListItem extends StatelessWidget {
  final String poster;
  final String title;
  final String subtitle;

  DLXListItem({Key key, this.poster, this.title, this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _poster = () {
//    print(doc['poster']);
      if (poster != null) {
        return FadeInImage.assetNetwork(
          placeholder: 'assets/placeholder_poster.png',
          image: poster,
        );
      } else {
        return Image(
          image: AssetImage('assets/placeholder_poster.png'),
        );
      }
    };

    var _title = Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Text(
        this.title ?? '',
        // style: Theme.of(context).textTheme.caption,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // softWrap: false,
        textAlign: TextAlign.left,
      ),
    );

    var _subtitle = Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: Text(
        this.title ?? '',
        // style: Theme.of(context).textTheme.caption,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        // softWrap: false,
        textAlign: TextAlign.left,
      ),
    );

    var _details = Column(
      children: <Widget>[_title, _subtitle],
    );

    // return Row(
    //   children: <Widget>[
    //     Container(
    //         width: 136.0, height: 200.0, color: Colors.red, child: _poster()),
    //     _details,
    //   ],

    //   // title: Text(title),
    //   // subtitle: Text(subtitle),
    // );

    return Container(
      // clipBehavior: Clip.antiAlias,
      // elevation: 4.0,
      color: Colors.blue,
      child: Row(
      children: <Widget>[
        Container(
            width: 136.0, height: 200.0, color: Colors.red, child: _poster()),
        _details,
      ],

      // title: Text(title),
      // subtitle: Text(subtitle),
    )
    );
  }
}
