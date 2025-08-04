class MoviesModelRequest {
  final int page;
  final List<MoviesModel> results;
  final int totalPages;

  MoviesModelRequest({
    required this.page,
    required this.results,
    required this.totalPages,
  });

  factory MoviesModelRequest.fromJson(Map<String, dynamic> json) {
    return MoviesModelRequest(
      page: json['page'],
      results:
          (json['results'] as List)
              .map((e) => MoviesModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalPages: json['total_pages'],
    );
  }
}

class MoviesModel {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final num voteAverage;
  final num voteCount;

  MoviesModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    return MoviesModel(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? '',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }
  toJson() {
    return {
      'id':id,
      'title':title,
      'posterPath':posterPath,
      'releaseDate':releaseDate,
      'voteAverage':voteAverage,
      'voteCount':voteCount
    };
  }
}
