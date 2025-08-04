import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/features/on_bording/model/on_bording_model.dart';

class OnBordingProvider extends ChangeNotifier {
  int currentPage = 0;
  final carouselController = CarouselSliderController();

  List<OnBordingModel> onBordingData = [
    OnBordingModel(
      title: 'OFFLINE',
      descreption:
          'Watch to your favorite film anywhere without an Internet connection',
      imagePath:
          'https://image.tmdb.org/t/p/w500/aFRDH3P7TX61FVGpaLhKr6QiOC1.jpg',
    ),
    OnBordingModel(
      title: 'FIND MOVIE',
      descreption: 'Watch and find movies that bring your mode back',
      imagePath:
          'https://cdn.prod.website-files.com/6009ec8cda7f305645c9d91b/66a4263d01a185d5ea22eeec_6408f6e7b5811271dc883aa8_batman-min.png',
    ),
    OnBordingModel(
      title: 'INVIET FRIENDS',
      descreption:
          'Create personal movie night space or accept your friends invitation!',
      imagePath:
          'https://image.tmdb.org/t/p/w500//2VUmvqsHb6cEtdfscEA6fqqVzLg.jpg',
    ),
  ];
  void changeIndex(int index) {
    currentPage = index;
    notifyListeners();
  }

  void incrementIndex() {
    currentPage++;
    carouselController.animateToPage(currentPage);
    notifyListeners();
  }
}
