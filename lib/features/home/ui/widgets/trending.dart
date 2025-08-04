import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return Consumer<HomeProvider>(
      builder: (context, _, _) {
        if (provider.isLoadingTrending) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder:
              (context, index) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Routes.movieDetails,
                    arguments: provider.trending[index].id,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: 'https://image.tmdb.org/t/p/w500${provider.trending[index].posterPath}',
                              height: 230,
                            ),
                          ),
                          Text(
                            provider.trending[index].title,
                            style: TextStyle(
                              fontSize: 18,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          separatorBuilder: (_, _) => SizedBox(width: 10),
          itemCount: provider.trending.length,
        );
      },
    );
  }
}
