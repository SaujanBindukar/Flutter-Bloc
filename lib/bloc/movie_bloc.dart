import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/repository/movie_repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final MovieRepo _movieRepo = MovieRepo();

  final BehaviorSubject<movie> _subject = BehaviorSubject<movie>();
  final BehaviorSubject<Genre> _genre = BehaviorSubject<Genre>();
  getMovie() async {
    movie movielist = await _movieRepo.getMovie();
    _subject.sink.add(movielist);
  }

  getGenre() async {
    Genre genrelist = await _movieRepo.getGenre();
    _genre.sink.add(genrelist);
  }

  dispose() {
    _subject.close();
    _genre.close();
  }

  BehaviorSubject<movie> get subject => _subject;
  BehaviorSubject<Genre> get genre => _genre;
}

final bloc = MovieBloc();
