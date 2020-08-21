class Movie {
  List<Results> results;

  Movie({this.results});

  Movie.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int id;
  bool video;
  int voteCount;
  String title;
  String releaseDate;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String posterPath;
  double popularity;
  String mediaType;
  String originalName;
  String name;
  String firstAirDate;

  Results({
    this.id,
    this.video,
    this.voteCount,
    this.title,
    this.releaseDate,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.posterPath,
    this.popularity,
    this.mediaType,
    this.originalName,
    this.name,
    this.firstAirDate,
  });

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    voteCount = json['vote_count'];

    title = json['title'];
    releaseDate = json['release_date'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    popularity = json['popularity'];
    mediaType = json['media_type'];
    originalName = json['original_name'];
    name = json['name'];
    firstAirDate = json['first_air_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['vote_count'] = this.voteCount;
    data['title'] = this.title;
    data['release_date'] = this.releaseDate;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['backdrop_path'] = this.backdropPath;
    data['adult'] = this.adult;
    data['overview'] = this.overview;
    data['poster_path'] = this.posterPath;
    data['popularity'] = this.popularity;
    data['media_type'] = this.mediaType;
    data['original_name'] = this.originalName;
    data['name'] = this.name;
    data['first_air_date'] = this.firstAirDate;

    return data;
  }
}
