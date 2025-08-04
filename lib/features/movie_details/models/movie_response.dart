class MovieResponse {
  final int id;
  final String backDropPath;
  final String posterPath;
  final String title;
  final String releaseDate;
  final num voteAverage;
  final num voteCount;
  final String overview;
  final List<GenersModel> genres;
  final num runtime;
  final String homepage;

  MovieResponse({
    required this.id,
    required this.backDropPath,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.overview,
    required this.genres,
    required this.runtime,
    required this.homepage,
  });
  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      id: json['id'],
      backDropPath: json["backdrop_path"],
      posterPath: json['poster_path'],
      title: json['title'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
      overview: json['overview'],
      genres:
          (json['genres'] as List<dynamic>)
              .map((e) => GenersModel.fromJson(e))
              .toList(),
      runtime: json['runtime'],
      homepage: json['homepage'],
    );
  }
  toJson() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'releaseDate': releaseDate,
      'voteAverage': voteAverage,
      'voteCount': voteCount,
    };
  }
}

class GenersModel {
  final int generId;
  final String name;

  GenersModel({required this.generId, required this.name});

  factory GenersModel.fromJson(Map<String, dynamic> json) {
    return GenersModel(generId: json['id'], name: json['name']);
  }
}
