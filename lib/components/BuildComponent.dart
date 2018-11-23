import 'package:flutter/material.dart';
import 'BuildGrid.dart';
import 'BuildList.dart';

class BuildComponent extends StatelessWidget {
  final dynamic compJson;

  BuildComponent(this.compJson);

  @override
  Widget build(BuildContext context) {
    String _type = compJson['type'] ?? 'unknown';
    switch (_type) {
      case "MediaGrid":
        // Build MediaGrid Widget
        // print('compJson');
        // print(compJson);
        return BuildGrid.fromJson(context, compJson);
        break;


        case "List":
        // Build MediaGrid Widget
        // print('compJson');
        // print(compJson);
        return BuildList.fromJson(compJson);
        break;



      // Default Widgegt
      default:
        return SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
                child: Center(
              child: Text(
                'error building component : $_type',
                style: Theme.of(context).textTheme.body2,
              ),
            )),
          ),
        );
    }
    // return Container(
    //   child: Text('error building component : $type'),
    // );
  }
}
