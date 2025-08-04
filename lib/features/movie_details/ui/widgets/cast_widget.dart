import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/style/app_color.dart';
import 'package:movies_app/features/movie_details/logic/movie_detials_provider.dart';
import 'package:provider/provider.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<MovieDetialsProvider>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cast',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemBuilder:
                  (context, index) => Row(
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        radius: 27,
                        child:
                            provider.cast[index].profileImage != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/w500${provider.cast[index].profileImage}',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Icon(Icons.person),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.cast[index].name,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(provider.cast[index].character),
                        ],
                      ),
                    ],
                  ),
              separatorBuilder: (_, _) => SizedBox(height: 10),
              itemCount: provider.cast.length,
            ),
          ),
          Text(
            'Crew',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
              itemBuilder:
                  (context, index) => Row(
                    spacing: 15,
                    children: [
                      CircleAvatar(
                        radius: 27,
                        child: provider.crew[index].profileImage != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: CachedNetworkImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/w500${provider.crew[index].profileImage}',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Icon(Icons.person),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.crew[index].name,
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(provider.crew[index].department),
                        ],
                      ),
                    ],
                  ),
              separatorBuilder: (_, _) => SizedBox(height: 10),
              itemCount: provider.crew.length,
            ),
          ),
        ],
      ),
    );
  }
}
