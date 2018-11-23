// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'dart:ui' as ui show Codec;
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'dart:io';
// import 'package:flutter/painting.dart';

class Utils {
  static Future<bool> loadImage(url) async {
    return http.get(url).then((res) {
      if (res.statusCode == 200) {
        return true;
      }
    });
  }

  static Future<List> jsonFetchList(String url, [String itemsSelector]) async {
    var res = await http.get(url);
    var resBody = json.decode(res.body);

    if (res.statusCode == 200) {
      // print('jsonFetchList body length');
      // print(resBody.length.toString());
      List<DataItem> temp = [];
      // print('itemsSelector');
      // print(itemsSelector);
      if (itemsSelector != null) {
        print('jsonFetchList + selector');
        for (int i = 0; i < resBody[itemsSelector].length; i++) {
          DataItem result = DataItem(resBody[itemsSelector][i]);
          temp.add(result);
          // print(result.data['title']);
        }
      } else {
        print('jsonFetchList without selector');
        for (int i = 0; i < resBody.length; i++) {
          DataItem result = DataItem(resBody[i]);
          temp.add(result);
          // print(result.data['title']);
        }
      }
      // print(temp.length);
      return temp;
    }
    return [];
  }

  static String stringVarMap(String _input, DataItem _item) {
    String _processed;
    String _matchGroup0;
    String _matchGroup1;
    // set the _input if any
    if (_input != null) {
      // print(_input);

      // Find vars in string between ${}
      // (?<=\${)(.*?)(?=\})
      RegExp regExp = new RegExp('{(.*?)}', caseSensitive: false);

      // print("allMatches : "+regExp.allMatches(_input).first.toString());
      // _input.replaceAllMapped(regExp, (Match m){
      //   print('Match : '+ m.groupCount.toString());
      // });

      Iterable<Match> matches = regExp.allMatches(_input);

      // print("matches.length : ${matches.length.toString()}");

      if (matches.length < 1) {
        // print(_input);
        return _processed = _input ?? 'no data';
      }

      for (Match match in matches) {
        _matchGroup0 = match.group(0);
        _matchGroup1 = match.group(1);

        // print('Match');

        // print("var : " + _input);

        // print(_item.data['snippet']['title'] ?? 'null');

        // print(match.toString());
        // print('match.group');
        // print(_matchGroup0);
        // print("group(1) : " + match.group(1) ?? "null");

        // Check for nested
        var nestedKeys = _matchGroup1.split('.');
        dynamic dat = _item.data;
        // nestedKeys.reduce((prev, curr){
        //   print("prev : " + prev);
        //   // print("curr : " + curr);
        //    dat = _item.data[prev];
        //    print(dat.runtimeType);
        //   // print("dat : ${ _item.data[prev][curr]}");
        // });
        _getNest(key) {
          if (dat.containsKey(key)) {
            // print("containsKey : " + key);
            // print(dat[key].toString());
            dat = dat[key];
          }
          // print("nope: " + key);
        }

        if (nestedKeys.length > 1) {
          // print(" > 1 - nestedKeys.length : " + nestedKeys.length.toString());

          for (var i = 0; i < nestedKeys.length; i++) {
            // print("NestedKeys [$i]  " + nestedKeys[i].toString());
            _getNest(nestedKeys[i]);
            // print(i);
          }
          _matchGroup1 = dat.toString();
          _processed = _input.replaceAll(_matchGroup0, _matchGroup1);
        } else if (nestedKeys.length == 1) {
          // print(" == 1 - nestedKeys.length : " + nestedKeys.length.toString());
          // Check if the key exist
          if (_item.data.containsKey(nestedKeys[0])) {
            _matchGroup1 = _item.data[nestedKeys[0]];
            if (_matchGroup1 == null) {
              _processed = _input;
            } else {
              _processed = _input.replaceAll(_matchGroup0, _matchGroup1);
            }
          } else {
            _processed = _input;
          }

          // print("_processed... " + _processed.toString());
        }

        // poster = poster.replaceAll('-large', '-t500x500');

        // print(_processed);
      }
      // print('_input');
      // print(_input);
    } else {
      // print(_item.data);
      if (_item.data['cover'] != null) {
        _processed = _item.data['cover'];
      }
    }

    return _processed;
  }
}

class DataItem {
  Map<String, dynamic> data;

  DataItem(Map<String, dynamic> jsonData) {
    data = jsonData;
  }
}
