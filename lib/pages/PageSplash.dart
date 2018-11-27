import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dlxtv/components/BuildApp.dart';
import 'package:dlxtv/utils/theme.dart';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  Future<String> getConfig(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString("assets/api.json");
  }

  @override
  Widget build(BuildContext context) {
    print('----\ Build Splash /----');
    return FutureBuilder(
      future: getConfig(context),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (snap.hasData) {
          if (snap.connectionState == ConnectionState.done) {
            // print('snap.data');
            // print(snap.data);
            var config = jsonDecode(snap.data.toString());
            // return AppModel.fromJson(context, config);
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: darkTheme,
                home: Scaffold(
                    body:  BuildApp(
                  appJson: config,
                )));
          }
        }

        // print(snap.toString());
        return Container(
          child: Image(
            image: AssetImage('assets/mario.png'),
          ),
        );
      },
    );
  }
}
