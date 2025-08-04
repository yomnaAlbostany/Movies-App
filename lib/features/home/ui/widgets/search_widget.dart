import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/core/style/app_color.dart';
import 'package:movies_app/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HomeProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<HomeProvider>(
          builder: (context, _, _) {
            return Column(
              spacing: 10,
              children: [
                TextFormField(
                  controller: provider.serachController,
                  onChanged: (value) {
                    provider.getSerachMovies(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Search any movies name here',
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    fillColor: const Color(0xFF252525),
                  ),
                ),
                if (provider.isLoadingSearch)
                  Expanded(child: Center(child: CircularProgressIndicator()))
                else if (provider.searchedMovies.isEmpty)
                  Expanded(
                    child: Center(child: Text('No results',style: TextStyle(
                      fontSize: 18
                    ),)),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.movieDetails,
                            arguments: provider.searchedMovies[index].id);
                          },
                          child: SizedBox(
                            height: 170,
                            child: Row(
                              spacing: 10,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(13),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w500/${provider.searchedMovies[index].posterPath}',
                                    height: 170,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 170,
                                        width: 120,
                                        color: const Color.fromARGB(255, 42, 42, 42),
                                        child: Icon(Icons.broken_image, size: 40, color: AppColor.primaryColor),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          provider.searchedMovies[index].title,
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
                                                    .searchedMovies[index]
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
                                                provider
                                                    .searchedMovies[index]
                                                    .voteCount
                                                    .toString(),
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            spacing: 6,
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                              ),
                                              Text(
                                                provider
                                                    .searchedMovies[index]
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
                      itemCount: provider.searchedMovies.length,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
