import 'package:movieapp/model/movie.dart';

class MovieResponse {
  final List<Movie> results;
  final String error;

  MovieResponse(this.results, this.error);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : results = (json["results"] as List)
            .map((i) => new Movie.fromJson(i))
            .toList(),
        error = "";

  MovieResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}
