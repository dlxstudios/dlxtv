import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:dlxtv/models/item_model.dart';

class TMDBAPI {

  var api = {
    "api_key": "130979ed329ff88f27bae32b141082fb",
    "base_url": "https://api.themoviedb.org/3/",
    "types": {"movie": "movie", "tv": "tv"},
  };

  static String baseURL = 'api.themoviedb.org/';
  static String version = '/3/';

  static Map<String, String> apiKey = {
    "api_key": "130979ed329ff88f27bae32b141082fb"
  };

  static Map<String, String> headers = {"Accept": "application/json"};

//https://api.themoviedb.org/3/movie/157336?api_key=130979ed329ff88f27bae32b141082fb&append_to_response=videos,images

  static Future<Map<String, dynamic>> getApi(String id) async {
//  var res = await http
//      .get(Uri.encodeFull("https://api.themoviedb.org/3/movie/157336?api_key=130979ed329ff88f27bae32b141082fb"), headers: {"Accept": "application/json"});
//  var res = await http
//      .get(movie.fragment+"movie/157336", headers: headers);

    var _movie = Uri.https(baseURL, version + "movie/$id", apiKey);
//
    var res = await http.get(_movie, headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);
    print("Get_API : ");
    print(resBody['original_title']);
    print(_movie);

    return resBody;
  }

  static Future<Map<String, dynamic>> getMovieByID(String id) async {
    var _movie = Uri.https('api.themoviedb.org', version + "movie/$id", apiKey);
    var res = await http.get(_movie);
    var resBody = json.decode(res.body);

    // title = original_title
    // cover =
    // description = overview
    // poster = poster_path

//    print("getMovieByID : " + id);
//    print(resBody['original_title']);
//    print(_movie);
//    var _poster = "https://image.tmdb.org/t/p/w500"+resBody['poster_path'];
//    print("poster info : " + _poster);
//    print("");

    var posterPath = resBody['poster_path'] ?? '';

    Map<String, String> item = {
      "title": resBody['original_title'],
//    item['poster'] = _poster;

      "poster": "https://image.tmdb.org/t/p/w500$posterPath",
    };
    return item;
  }

  static Future<ItemModel> getPopular() async {
    final response = await http
        .get("http://api.themoviedb.org/3/movie/popular?api_key=130979ed329ff88f27bae32b141082fb");
//    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
//      var item = ItemModel.fromJson(json.decode(response.body));
//      print(item.results[0].title);
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  static Future<ItemModel> getSearch(String query) async {
    var query = 'bobs burgers';
    final response = await http
        .get("https://api.themoviedb.org/3/search/multi?api_key=130979ed329ff88f27bae32b141082fb&query=$query");
  //  print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
//      var item = ItemModel.fromJson(json.decode(response.body));
    //  print(json.decode(response.body));
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

}
