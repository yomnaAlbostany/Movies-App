import 'package:flutter/material.dart';
import 'package:movies_app/features/movie_details/logic/movie_detials_provider.dart';
import 'package:provider/provider.dart';

class GenresWidget extends StatelessWidget {
  const GenresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieDetialsProvider>();
    return SizedBox(
      height: 300,
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (provider.movie.genres.isEmpty) {
            return Text('No genres available');
          }
          return Row(
            spacing: 10,
            children: [
              Icon(provider.genreIcons[provider.movie.genres[index].name]),
              Text(provider.movie.genres[index].name,style: TextStyle(
                fontSize: 16
              ),),
            ],
          );
        },
        separatorBuilder: (_, _) => SizedBox(height: 20),
        itemCount: provider.movie.genres.length,
      ),
    );
  }

  
}
