import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/movieById.dart';
import 'package:movieapp/model/topRated.dart';
import 'package:movieapp/networking/api_provider.dart';

class MovieRepo {
  ApiProvider _apiProvider = ApiProvider();

  Future<Movie> getMovie() {
    return _apiProvider.getMovie("trending/all/day");
  }

  Future<Genre> getGenre() {
    return _apiProvider.getGenre("genre/movie/list");
  }

  Future<MovieById> getMovieById(int id) {
    return _apiProvider.getMovieById(id);
  }

  Future<TopRated> getTopRated() {
    return _apiProvider.getTopRated("movie/top_rated");
  }

  Future<TopRated> getUpcomming() {
    return _apiProvider.getUpcomming("movie/upcoming");
  }

  Future<TopRated> getPopular() {
    return _apiProvider.getUpcomming("movie/popular");
  }

  Future<TopRated> getMovieByName(String movieName) {
    return _apiProvider.getMovieByName(movieName);
  }
}
