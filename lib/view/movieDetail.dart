import 'package:flutter/material.dart';
import 'package:movieapp/bloc/movie_bloc.dart';
import 'package:movieapp/model/movieById.dart';

class MovieDetail extends StatefulWidget {
  final int id;

  const MovieDetail({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  void initState() {
    super.initState();
    bloc.getMovieById(widget.id);
    print("Movie id" + widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
      appBar: AppBar(
        centerTitle: false,
        title: Text("Movie Detail"),
        backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
        elevation: 0,
      ),
      body: ListView(
        children: [
          StreamBuilder<MovieById>(
            stream: bloc.movieById.stream,
            builder: (
              context,
              AsyncSnapshot<MovieById> snapshot,
            ) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      snapshot.data.posterPath != null
                          ? Image.network(
                              "https://image.tmdb.org/t/p/original" +
                                  snapshot.data.posterPath,
                              height: MediaQuery.of(context).size.height / 1.5,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            )
                          : Container(),
                      SizedBox(
                        height: 30,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data.originalTitle,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.date_range),
                                    Text(
                                      snapshot.data.releaseDate,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.timelapse),
                                    Text(
                                      snapshot.data.runtime.toString() + "min",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 30,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data.genres.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: 1)),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(snapshot
                                                  .data.genres[index].name),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  snapshot.data.overview,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Text("Error ");
              }
            },
          ),
        ],
      ),
    );
  }
}
