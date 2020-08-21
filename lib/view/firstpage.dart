import 'package:flutter/material.dart';
import 'package:movieapp/bloc/movie_bloc.dart';
import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/topRated.dart';
import 'package:movieapp/view/movieDetail.dart';
import 'package:page_indicator/page_indicator.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void initState() {
    super.initState();
    bloc.getMovie();
    bloc.getGenre();
    bloc.getTopRated();
    bloc.getUpcomming();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Movie App"),
        elevation: 0,
        backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              genre(context),
              trendingMovie(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Top Rated",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              topRated(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Upcomming",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              upcomming(context),
            ],
          ),
        ],
      ),
    );
  }
}

Widget trendingMovie(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 3,
    child: StreamBuilder<Movie>(
      stream: bloc.subject.stream,
      builder: (
        context,
        AsyncSnapshot<Movie> snapshot,
      ) {
        if (snapshot.hasData) {
          return PageIndicatorContainer(
            align: IndicatorAlign.bottom,
            indicatorSelectorColor: Colors.yellow,
            indicatorColor: Colors.white,
            length: 5,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.results.take(5).length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print(snapshot.data.results[index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(id: snapshot.data.results[index].id),
                        ));
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Image.network(
                            "https://image.tmdb.org/t/p/original" +
                                snapshot.data.results[index].backdropPath,
                            height: MediaQuery.of(context).size.height / 3),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 3 - 50,
                        child: snapshot.data.results[index].originalName != null
                            ? Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  snapshot.data.results[index].originalName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  snapshot.data.results[index].originalTitle,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      )
                    ],
                  ),
                );
              },
            ),
          );
        }
        return Container();
      },
    ),
  );
}

Widget genre(BuildContext context) {
  return Container(
    height: 60,
    child: StreamBuilder<Genre>(
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
                return InkWell(
                  onTap: () {
                    print(snapshot.data.genres[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.genres[index].name,
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          Text("Error");
        }
        return Container();
      },
    ),
  );
}

Widget topRated(BuildContext context) {
  return Container(
    height: 220,
    child: StreamBuilder<TopRated>(
      stream: bloc.topRated.stream,
      builder: (
        context,
        AsyncSnapshot<TopRated> snapshot,
      ) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // print(snapshot.data.genres[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/original" +
                                    snapshot.data.results[index].backdropPath,
                                height: 150,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Container(
                            width: 100,
                            child: Text(
                              snapshot.data.results[index].originalTitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          Text("Error");
        }
        return Container();
      },
    ),
  );
}

Widget upcomming(BuildContext context) {
  return Container(
    height: 220,
    child: StreamBuilder<TopRated>(
      stream: bloc.upcomming.stream,
      builder: (
        context,
        AsyncSnapshot<TopRated> snapshot,
      ) {
        if (snapshot.hasData) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.results.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    // print(snapshot.data.genres[index].id);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/original" +
                                    snapshot.data.results[index].backdropPath,
                                height: 150,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            )),
                        Container(
                            width: 100,
                            child: Text(
                              snapshot.data.results[index].originalTitle,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ))
                      ],
                    ),
                  ),
                );
              });
        }
        if (snapshot.hasError) {
          Text("Error");
        }
        return Container();
      },
    ),
  );
}
