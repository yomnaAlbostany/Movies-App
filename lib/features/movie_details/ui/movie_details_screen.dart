import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/style/app_color.dart';
import 'package:movies_app/features/home/logic/favorite_provider.dart';
import 'package:movies_app/features/movie_details/logic/movie_detials_provider.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;
  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieDetialsProvider>();
    final favoriteProvider = context.read<FavoriteProvider>();
    return Consumer2<MovieDetialsProvider, FavoriteProvider>(
      builder: (context, _, _, _) {
        return provider.isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
              appBar: AppBar(
                title: Text('Detail'),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      favoriteProvider.toggleFavorite(provider.movie);
                    },
                    icon:favoriteProvider.isFavorite(provider.movie)? Icon(Icons.favorite, color: AppColor.primaryColor):Icon(Icons.favorite),
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 15,
                  children: [
                    SizedBox(
                      height: 300,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color.fromARGB(41, 255, 255, 255),
                                  const Color.fromARGB(36, 255, 255, 255),
                                ],
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500/${provider.movie.backDropPath}',
                              ),
                            ),
                          ),
                          Positioned(
                            top: 120,
                            left: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w500/${provider.movie.posterPath}',
                                height: 190,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 224,
                            right: 10,
                            left: 190,
                            child: Text(
                              provider.movie.title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          Positioned(
                            right: 15,
                            bottom: 89,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(192, 0, 0, 0),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                child: Row(
                                  spacing: 5,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star_border_outlined,
                                      color: Color(0xffFF8700),
                                    ),
                                    Text(
                                      provider.movie.voteAverage.toString(),
                                      style: TextStyle(
                                        color: Color(0xffFF8700),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            spacing: 6,
                            children: [
                              Icon(Icons.calendar_today, size: 19),
                              Text(
                                provider.movie.releaseDate.split('-')[0],
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),

                          Row(
                            spacing: 6,
                            children: [
                              Icon(Icons.access_time, size: 19),
                              Text(
                                '${provider.movie.runtime} Minutes',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                          Row(
                            spacing: 6,
                            children: [
                              Icon(Icons.how_to_vote, size: 19),
                              Text(
                                provider.movie.voteCount.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 25,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Center(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              bool isSelected = index == provider.currentIndex;
                              return InkWell(
                                onTap: () {
                                  provider.changeIndex(index);
                                },
                                child: Text(
                                  provider.categories[index],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, _) => SizedBox(width: 20),
                            itemCount: 3,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: provider.categoryData[provider.currentIndex],
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
