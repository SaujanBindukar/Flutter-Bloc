import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/movieById.dart';
import 'package:movieapp/model/topRated.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final MovieRepo _movieRepo = MovieRepo();

  final BehaviorSubject<Movie> _subject = BehaviorSubject<Movie>();
  final BehaviorSubject<Genre> _genre = BehaviorSubject<Genre>();
  final BehaviorSubject<MovieById> _movieById = BehaviorSubject<MovieById>();
  final BehaviorSubject<TopRated> _topRated = BehaviorSubject<TopRated>();
  final BehaviorSubject<TopRated> _upcomming = BehaviorSubject<TopRated>();

  final BehaviorSubject<TopRated> _popular = BehaviorSubject<TopRated>();

  final BehaviorSubject<TopRated> _movieName = BehaviorSubject<TopRated>();

  getMovie() async {
    Movie movielist = await _movieRepo.getMovie();
    _subject.sink.add(movielist);
  }

  getTopRated() async {
    TopRated movielist = await _movieRepo.getTopRated();
    _topRated.sink.add(movielist);
  }

  getUpcomming() async {
    TopRated movielist = await _movieRepo.getUpcomming();
    _upcomming.sink.add(movielist);
  }

  getGenre() async {
    Genre genrelist = await _movieRepo.getGenre();
    _genre.sink.add(genrelist);
  }

  getMovieById(int id) async {
    MovieById movielist = await _movieRepo.getMovieById(id);
    _movieById.sink.add(movielist);
  }

  getPopular() async {
    TopRated movielist = await _movieRepo.getPopular();
    _popular.sink.add(movielist);
  }

  getMovieByName(String movieName) async {
    TopRated movielist = await _movieRepo.getMovieByName(movieName);
    _movieName.sink.add(movielist);
  }

  dispose() {
    _subject.close();
    _genre.close();
    _movieById.close();
    _topRated.close();
    _upcomming.close();
    _popular.close();
    _movieName.close();
  }

  BehaviorSubject<Movie> get subject => _subject;
  BehaviorSubject<Genre> get genre => _genre;
  BehaviorSubject<MovieById> get movieById => _movieById;
  BehaviorSubject<TopRated> get topRated => _topRated;
  BehaviorSubject<TopRated> get upcomming => _upcomming;
  BehaviorSubject<TopRated> get popular => _popular;
  BehaviorSubject<TopRated> get movieName => _movieName;
}

final bloc = MovieBloc();
