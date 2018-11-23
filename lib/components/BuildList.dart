import 'package:flutter/material.dart';

class BuildList extends StatelessWidget {
 final dynamic compJson;

  BuildList(this.compJson);

 BuildList.fromJson(this.compJson);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 16.0),
      sliver: SliverToBoxAdapter(
        child: SizedBox.fromSize(
          size: Size.fromHeight(150.0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              // var video = artist.videos[index];
              // return VideoCard(video);
              return Container(
                color: Colors.red,
                child:Text('Item $index'),
              );
            },
          ),
        ),
      ),
    );
  }
}
