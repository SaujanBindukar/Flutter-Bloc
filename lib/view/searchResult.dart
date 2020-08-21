import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/bloc/movie_bloc.dart';
import 'package:movieapp/model/topRated.dart';
import 'package:movieapp/view/movieDetail.dart';

class SearchResult extends StatefulWidget {
  final String movieName;
  SearchResult({Key key, this.movieName}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  void initState() {
    super.initState();
    bloc.getMovieByName(widget.movieName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        title: Text("Search Result"),
        backgroundColor: Color.fromARGB(0xff, 19, 50, 85),
      ),
      body: StreamBuilder<TopRated>(
          stream: bloc.movieName.stream,
          builder: (context, AsyncSnapshot<TopRated> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0),
                itemCount: snapshot.data.results.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetail(
                                id: snapshot.data.results[index].id),
                          ));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            snapshot.data.results[index].backdropPath != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original" +
                                            snapshot.data.results[index]
                                                .backdropPath,
                                    height: 150,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                : snapshot.data.results[index].posterPath !=
                                        null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "https://image.tmdb.org/t/p/original" +
                                                snapshot.data.results[index]
                                                    .posterPath,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Container(
                                        height: 150,
                                        width: 120,
                                        color: Colors.black,
                                      ),
                            snapshot.data.results[index].title != null
                                ? Text(
                                    snapshot.data.results[index].title,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    snapshot.data.results[index].originalTitle,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                            SizedBox()
                          ],
                        )),
                  );
                },
              );
            } else {
              return Text("${snapshot.error}");
            }
          }),
    );
  }
}
