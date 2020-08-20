import 'package:flutter/material.dart';
import 'package:movieapp/bloc/movie_bloc.dart';
import 'package:movieapp/model/movie.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    super.initState();
    bloc.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Treding movies"),
      ),
      body: StreamBuilder<movie>(
        stream: bloc.subject.stream,
        builder: (
          context,
          AsyncSnapshot<movie> snapshot,
        ) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                          "https://image.tmdb.org/t/p/original" +
                              snapshot.data.results[index].backdropPath),
                    ),
                    snapshot.data.results[index].originalTitle != null
                        ? Text(snapshot.data.results[index].originalTitle)
                        : Text(snapshot.data.results[index].originalName),
                  ],
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
