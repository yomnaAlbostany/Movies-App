import 'package:flutter/material.dart';
import 'package:movies_app/features/movie_details/logic/movie_detials_provider.dart';
import 'package:provider/provider.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieDetialsProvider>();
    return Text(provider.movie.overview);
  }
}
