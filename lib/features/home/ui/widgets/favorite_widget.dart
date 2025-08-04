import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/features/home/logic/favorite_provider.dart';
import 'package:provider/provider.dart';

class FavoriteWidget extends StatelessWidget {
  const FavoriteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<FavoriteProvider>();
    return Consumer<FavoriteProvider>(
      builder: (context, _, _) {
        if (provider.favorites.isEmpty) {
          return Expanded(
            child: Center(
              child: Text('No results', style: TextStyle(fontSize: 18)),
            ),
          );
        } else {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Routes.movieDetails,
                        arguments: provider.favorites[index].id,
                      );
                    },
                    child: SizedBox(
                      height: 170,
                      child: Row(
                        spacing: 10,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500/${provider.favorites[index].posterPath}',
                              height: 170,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    provider.favorites[index].title,
                                    style: TextStyle(
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                Column(
                                  spacing: 12,
                                  children: [
                                    Row(
                                      spacing: 6,
                                      children: [
                                        Icon(
                                          Icons.star_border_outlined,
                                          color: Color(0xffFF8700),
                                        ),
                                        Text(
                                          provider
                                              .favorites[index]
                                              .voteAverage
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Color(0xffFF8700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 6,
                                      children: [
                                        Icon(Icons.how_to_vote),
                                        Text(
                                          provider.favorites[index].voteCount
                                              .toString(),
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      spacing: 6,
                                      children: [
                                        Icon(Icons.calendar_today_outlined),
                                        Text(
                                          provider
                                              .favorites[index]
                                              .releaseDate
                                              .split('-')[0],
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, _) => SizedBox(height: 20),
                itemCount: provider.favorites.length,
              ),
            ),
          );
        }
      },
    );
  }
}
