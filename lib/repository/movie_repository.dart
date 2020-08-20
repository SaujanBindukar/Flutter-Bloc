import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/networking/api_provider.dart';

class MovieRepo {
  ApiProvider _apiProvider = ApiProvider();

  Future<movie> getMovie() {
    return _apiProvider.getMovie("trending/all/day");
  }

  Future<Genre> getGenre() {
    return _apiProvider.getGenre("genre/movie/list");
  }
}
