


class ItemModel {
  int _page;
  int _totalResults;
  int _totalPages;
  List<Result> _results = [];

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
//    print(parsedJson['results'].length);
    _page = parsedJson['page'];
    _totalResults = parsedJson['totalResults'];
    _totalPages = parsedJson['totalPages'];
    List<Result> temp = [];
    for (int i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    _results = temp;
  }

  List<Result> get results => _results;

  int get totalPages => _totalPages;

  int get totalResults => _totalResults;

  int get page => _page;
}

class Result {
  int _voteCount;
  int _id;
  bool _video;
  var _voteAverage;
  String _title;
  double _popularity;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreIDs = [];
  String _backdropPath;
  bool _adult;
  String _overview;
  String _releaseDate;

  Result(result) {

    var _posterPath = result['poster_path'];
    var _backdropPath = result['backdrop_path'];

    _voteCount = result['vote_count'];
    _id = result['id'];
    _video = result['video'];
    _voteAverage = result['vote_average'];
    _title = result['title'];
    _popularity = result['popularity'];
    _posterPath = "https://image.tmdb.org/t/p/w500$_posterPath";
    _originalLanguage = result['original_language'];
    _originalTitle = result['original_title'];
    for (int i = 0; i < result['genre_ids'].length; i++) {
      _genreIDs.add(result['genre_ids'][i]);
    }
    _backdropPath = "https://image.tmdb.org/t/p/w1280$_backdropPath";
//    print(_backdropPath);
    _adult = result['adult'];
    _overview = result['overview'];
    _releaseDate = result['release_date'];
  }

  String get release_date => _releaseDate;

  String get overview => _overview;

  bool get adult => _adult;

  String get backdrop_path => _backdropPath;

  List<int> get genre_ids => _genreIDs;

  String get original_title => _originalTitle;

  String get original_language => _originalLanguage;

  String get poster_path => _posterPath;

  double get popularity => _popularity;

  String get title => _title;

  double get vote_average => _voteAverage;

  bool get video => _video;

  int get id => _id;

  int get vote_count => _voteCount;
}
