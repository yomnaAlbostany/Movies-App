import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/core/network/dio_factory.dart';
import 'package:movies_app/features/movie_details/models/cast_response.dart';
import 'package:movies_app/features/movie_details/models/movie_response.dart';
import 'package:movies_app/features/movie_details/ui/widgets/about_widget.dart';
import 'package:movies_app/features/movie_details/ui/widgets/cast_widget.dart';
import 'package:movies_app/features/movie_details/ui/widgets/genres_widget.dart';

class MovieDetialsProvider extends ChangeNotifier {
  bool isLoading = false;
  late MovieResponse movie;
  void getMovie(int movieId) async {
    isLoading = true;
    notifyListeners();
    final response = await DioFactory.getData(path: 'movie/$movieId');
    final data = MovieResponse.fromJson(response.data);
    movie = data;
    isLoading = false;
    notifyListeners();
  }

  List<String> categories = ['About Movie', 'Genres', 'Cast'];
  int currentIndex = 0;
  List<Widget> categoryData = [AboutWidget(), GenresWidget(), CastWidget()];
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<CastModel> cast = [];
  List<CrewModel> crew = [];
  void getCast(int movieId) async {
    cast.clear();
    crew.clear();
    final response = await DioFactory.getData(path: 'movie/$movieId/credits');
    final data = CastResponse.fromJson(response.data);
    log(data.toString());
    cast.addAll(data.cast);
    crew.addAll(data.crew);
    notifyListeners();
  }
  Map<String, IconData> genreIcons = {
  "Action": Icons.flash_on,
  "Adventure": Icons.explore,
  "Animation": Icons.animation, // Requires Flutter 3.10+
  "Comedy": Icons.emoji_emotions,
  "Crime": Icons.gavel,
  "Documentary": Icons.menu_book,
  "Drama": Icons.theater_comedy,
  "Family": Icons.family_restroom,
  "Fantasy": Icons.auto_awesome,
  "History": Icons.history_edu,
  "Horror": Icons.nightlight,
  "Music": Icons.music_note,
  "Mystery": Icons.help_outline,
  "Romance": Icons.favorite,
  "Science Fiction": Icons.science,
  "TV Movie": Icons.live_tv,
  "Thriller": Icons.local_police,
  "War": Icons.military_tech,
  "Western": Icons.west,
};

}
