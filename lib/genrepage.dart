import 'package:flutter/material.dart';
import 'package:movieapp/bloc/movie_bloc.dart';
import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';

class GenrePage extends StatefulWidget {
  GenrePage({Key key}) : super(key: key);

  @override
  _GenrePageState createState() => _GenrePageState();
}

class _GenrePageState extends State<GenrePage> {
  void initState() {
    super.initState();
    bloc.getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Treding movies"),
      ),
      body: StreamBuilder<Genre>(
        stream: bloc.genre.stream,
        builder: (
          context,
          AsyncSnapshot<Genre> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.genres.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(snapshot.data.genres[index].name);
                });
          }
          return Container();
        },
      ),
    );
  }
}
