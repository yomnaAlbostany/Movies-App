import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movies_app/features/movie_details/models/movie_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  List<MovieResponse> _favorites = [];

  List<MovieResponse> get favorites => _favorites;

  void toggleFavorite(movie) {
    final existingIndex = _favorites.indexWhere((m) => m.id == movie.id);
    if (existingIndex >= 0) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
    _saveFavorites();
  }

  bool isFavorite(movie) {
    return _favorites.any((m) => m.id == movie.id);
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList =
        _favorites.map((movie) => jsonEncode(movie.toJson())).toList();
    prefs.setStringList('favorites', jsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('favorites');
    if (jsonList != null) {
      _favorites =
          jsonList
              .map((item) => MovieResponse.fromJson(jsonDecode(item)))
              .toList();
      notifyListeners();
    }
  }
}