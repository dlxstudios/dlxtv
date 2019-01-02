import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:dlxtv/pages/DLXMediaHomeList.dart';
// import 'pages/pageGrid.dart';
import 'pages/PageSplash.dart';

// import 'utils/theme.dart';

void main() => runApp(new TVApp());

class TVApp extends StatelessWidget {
  // dynamic config = "";
  // List items;

  // Widget getAPI(BuildContext context) {

  //   return DefaultAssetBundle.of(context)
  //       .loadString("assets/api.json")
  //       .then((_data) {
  //     // print(_data);
  //     config = json.decode(_data.toString());
  //     // print(config);
  //     AppModel app = AppModel.fromJson(config);
  //     print(app.title);
  //     return app;
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return PageSplash();
  }

  ///Generate parameterized route --> e.g: detail/some book title
//  generateRoute(RouteSettings settings) {
//    final path = settings.name.split('/');
//    final title = path[1];
//
//    Book book = books.firstWhere((it) => it.title == title);
//    return MaterialPageRoute(
//      settings: settings,
//      builder: (context) => Detail(book),
//    );
//  }
}

// Widget getAPI(BuildContext context) {
//     AppModel _app;
//     try {
//       Future<String> data =
//           DefaultAssetBundle.of(context).loadString("assets/api.json");
//       data.then((_data) {
//         // print(_data);
//         config = json.decode(_data.toString());
//         // print(config);
//         AppModel app = AppModel.fromJson(config);
//         print(app.title);

//       });
//     } catch (e) {
//       print("Error");
//     }

//      return _app;
//   }



