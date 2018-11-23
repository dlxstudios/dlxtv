import 'package:flutter/material.dart';
import 'package:dlxtv/components/BuildComponent.dart';

class BuildPage extends StatelessWidget {
  String title = "new skool";
  String path = "/";
  Map<String, dynamic> pageJson;

  List<Widget> _components = [];

  BuildPage({Key key, title, path, this.pageJson}) : super(key: key);
  BuildPage.fromJson(this.pageJson) {
    // print('pageJson : ');
    // print(pageJson);
    title = pageJson['title'] ?? 'Untitled';
    path = pageJson['path'] ?? '/';

    if (pageJson.containsKey('components')) {
      // compute components
      List<dynamic> _comps = pageJson['components'];

      for (var comp in _comps) {
        _components.add(BuildComponent(comp));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _header = SliverAppBar(
      backgroundColor: Colors.green,
      centerTitle: true,
      title: Text(title),
    );

// _components.insert(0, _header);

    if (_components.length > 0) {
      return CustomScrollView(
        primary: true,
        slivers: _components,
      );
    }

    return Container(
      child: Center(
        child: Text("No components for page '$title'"),
      ),
    );
  }
}
