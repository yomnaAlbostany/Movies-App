import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class MoviesWidget extends StatelessWidget {
  const MoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return Consumer<HomeProvider>(
      builder: (context, _, _) {
        return Column(
          spacing: 10,
          children: [
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  bool isSelected = provider.selectedCategories == index;
                  return InkWell(
                    onTap: () {
                      provider.changeCategory(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Theme.of(context).colorScheme.primary
                                : const Color(0x00FFFFFF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              isSelected
                                  ? const Color(0x00FFFFFF)
                                  : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          provider.categories[index],
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, _) => SizedBox(width: 20),
                itemCount: 3,
              ),
            ),
            if (provider.isLoadingMovies)
            SizedBox(
              height: 250,
              child: Center(child: CircularProgressIndicator(),))
            else
            GridView.builder(
              
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: provider.movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemBuilder:
                  (context, index) => InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.movieDetails,arguments: provider.movies[index].id);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: 'https://image.tmdb.org/t/p/w500${provider.movies[index].posterPath}',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          provider.movies[index].title,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
            ),
          ],
        );
      },
    );
  }
}
