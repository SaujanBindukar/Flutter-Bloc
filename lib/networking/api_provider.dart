import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:dio/dio.dart';
import 'package:movieapp/model/movieById.dart';
import 'package:movieapp/model/topRated.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api.themoviedb.org/3/";

  final String apiKey = "8b64a757db3ca10e01db9a717db9b331";

  Future<Movie> getMovie(String url) async {
    try {
      Response response = await _dio.get(_baseUrl + url + "?api_key=" + apiKey);
      return Movie.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<TopRated> getTopRated(String url) async {
    try {
      Response response = await _dio.get(_baseUrl + url + "?api_key=" + apiKey);
      return TopRated.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<Genre> getGenre(String url) async {
    try {
      Response response = await _dio.get(_baseUrl + url + "?api_key=" + apiKey);
      return Genre.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<MovieById> getMovieById(int id) async {
    try {
      Response response = await _dio
          .get(_baseUrl + "movie/" + id.toString() + "?api_key=" + apiKey);
      return MovieById.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }

  Future<TopRated> getUpcomming(String url) async {
    try {
      Response response = await _dio.get(_baseUrl + url + "?api_key=" + apiKey);
      return TopRated.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }
}
