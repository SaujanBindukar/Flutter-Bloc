import 'package:flutter/material.dart';
import 'package:movieapp/bloc/movie_bloc.dart';
import 'package:movieapp/model/genre.dart';
import 'package:movieapp/model/movie.dart';
import 'package:movieapp/model/topRated.dart';
import 'package:movieapp/view/movieDetail.dart';
import 'package:movieapp/view/searchResult.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final movieName = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    movieName.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    bloc.getMovie();
    bloc.getGenre();
    bloc.getTopRated();
    bloc.getUpcomming();
    bloc.getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Movie App",
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              child: Center(
                child: TextField(
                  onSubmitted: (value) => {
                    print(movieName.text),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResult(
                                movieName: movieName.text,
                              )),
                    )
                  },
                  textInputAction: TextInputAction.search,
                  controller: movieName,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Search Movie",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        5.0,
                      ),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.white,
                        // style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Popular",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              popular(context),
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
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: "https://image.tmdb.org/t/p/original" +
                                snapshot.data.results[index].backdropPath,
                            height: MediaQuery.of(context).size.height / 3,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
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
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error loading the data...",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          );
        }

        return CircularProgressIndicator();
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
                    print(snapshot.data.results[index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(id: snapshot.data.results[index].id),
                        ));
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
                              child: CachedNetworkImage(
                                imageUrl:
                                    "https://image.tmdb.org/t/p/original" +
                                        snapshot
                                            .data.results[index].backdropPath,
                                height: 150,
                                width: 120,
                                fit: BoxFit.fitHeight,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
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
                    print(snapshot.data.results[index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(id: snapshot.data.results[index].id),
                        ));
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
                              child:
                                  snapshot.data.results[index].backdropPath !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original" +
                                                  snapshot.data.results[index]
                                                      .backdropPath,
                                          height: 150,
                                          width: 120,
                                          fit: BoxFit.fitHeight,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original" +
                                                  snapshot.data.results[index]
                                                      .posterPath,
                                          height: 150,
                                          width: 120,
                                          fit: BoxFit.fitHeight,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
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

Widget popular(BuildContext context) {
  return Container(
    height: 220,
    child: StreamBuilder<TopRated>(
      stream: bloc.popular.stream,
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
                    print(snapshot.data.results[index].id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MovieDetail(id: snapshot.data.results[index].id),
                        ));
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
                              child:
                                  snapshot.data.results[index].backdropPath !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original" +
                                                  snapshot.data.results[index]
                                                      .backdropPath,
                                          height: 150,
                                          width: 120,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original" +
                                                  snapshot.data.results[index]
                                                      .posterPath,
                                          height: 150,
                                          width: 120,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
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
