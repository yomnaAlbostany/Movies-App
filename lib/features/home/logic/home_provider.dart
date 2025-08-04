import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/network/dio_factory.dart';
import 'package:movies_app/features/home/models/trending_model.dart';
import 'package:movies_app/features/home/ui/widgets/favorite_widget.dart';
import 'package:movies_app/features/home/ui/widgets/home_widget.dart';
import 'package:movies_app/features/home/ui/widgets/search_widget.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> screens = [HomeWidget(), SearchWidget(), FavoriteWidget()];
  bool isLoadingTrending = false;
  List<MoviesModel> trending = [];
  void getTrends() async {
    isLoadingTrending = true;
    notifyListeners();
    final response = await DioFactory.getData(path: ApiConstants.trending);
    final data = MoviesModelRequest.fromJson(response.data);
    trending.addAll(data.results);
    isLoadingTrending = false;
    notifyListeners();
  }

  int selectedCategories = 0;
  List<String> endpoints = [
    ApiConstants.nowPlaying,
    ApiConstants.topRated,
    ApiConstants.upcoming,
  ];
  List<String> categories = ['Now Playing', 'Top Rated', 'Upcoimg'];
  List<MoviesModel> movies = [];
  bool isLoadingMovies = false;
  void getMovies(String path) async {
    isLoadingMovies = true;
    notifyListeners();
    movies.clear();
    final response = await DioFactory.getData(path: path);
    final data = MoviesModelRequest.fromJson(response.data);
    movies.addAll(data.results);
    isLoadingMovies = false;
    notifyListeners();
  }

  void changeCategory(int index) {
    selectedCategories = index;
    getMovies(endpoints[index]);
    notifyListeners();
  }

  final serachController = TextEditingController();
  bool isLoadingSearch = false;
  List<MoviesModel> searchedMovies = [];
  void getSerachMovies(String query) async {
    searchedMovies.clear();
    notifyListeners();
    if (query.isEmpty) {
      searchedMovies.clear();
      notifyListeners();
    }
    isLoadingSearch = true;
    notifyListeners();
    final response = await DioFactory.getData(
      path: ApiConstants.serach,
      queryParams: {'query': query},
    );
    final data = MoviesModelRequest.fromJson(response.data);
    log(data.toString());
    searchedMovies.addAll(data.results);
    isLoadingSearch = false;
    notifyListeners();
  }

  // List<MoviesModel> favorite = [];
  // void addMovieToFavorite(int movieId) {
  //   favorite = movies.where((e) => e.id == movieId).toList();
  //   favorite = trending.where((e) => e.id == movieId).toList();
  //   notifyListeners();
  // }
}
