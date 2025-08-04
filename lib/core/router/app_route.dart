import 'package:flutter/material.dart';
import 'package:movies_app/core/network/api_constants.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/features/home/logic/home_provider.dart';
import 'package:movies_app/features/home/ui/home_screen.dart';
import 'package:movies_app/features/movie_details/logic/movie_detials_provider.dart';
import 'package:movies_app/features/movie_details/ui/movie_details_screen.dart';
import 'package:movies_app/features/on_bording/logic/on_bording_provider.dart';
import 'package:movies_app/features/on_bording/ui/on_bording_screen.dart';
import 'package:movies_app/features/splash/ui/splash_screen.dart';
import 'package:provider/provider.dart';

class AppRoute {
  Route onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case Routes.onBording:
        return MaterialPageRoute(
          builder:
              (context) => ChangeNotifierProvider(
                create: (context) => OnBordingProvider(),
                child: OnBordingScreen(),
              ),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => HomeProvider()
              ..getTrends()
              ..getMovies(ApiConstants.nowPlaying),
            child: HomeScreen(),
          ),
        );

      case Routes.movieDetails:
        final id = setting.arguments as int;
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => MovieDetialsProvider()
              ..getMovie(id)
              ..getCast(id),
            child: MovieDetailsScreen(id: id),
          ),
        );

      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
