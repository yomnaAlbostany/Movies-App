import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/router/routes.dart';
import 'package:movies_app/features/on_bording/logic/on_bording_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnBordingProvider>();
    return Scaffold(
      body: SafeArea(
        child: Consumer<OnBordingProvider>(
          builder: (context, _, _) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                spacing: 10,
                children: [
                  Expanded(
                    child: CarouselSlider.builder(
                      carouselController: provider.carouselController,
                      itemCount: provider.onBordingData.length,
                      itemBuilder:
                          (context, index, realIndex) => Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(35),
                                  bottomRight: Radius.circular(35),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl:  provider.onBordingData[index].imagePath,
                                  height: 550,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.onBordingData[index].title,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      provider.onBordingData[index].descreption,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      options: CarouselOptions(
                        initialPage: 0,
                        height: double.infinity,
                        onPageChanged: (index, reason) {
                          provider.changeIndex(index);
                        },
                        enableInfiniteScroll: false,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (provider.currentPage ==
                          provider.onBordingData.length - 1) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.home,
                          (_) => false,
                        );
                      } else {
                        provider.incrementIndex();
                      }
                    },
                    child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  AnimatedSmoothIndicator(
                    effect: WormEffect(
                      dotHeight: 4,
                      dotWidth: 50,
                      activeDotColor: Theme.of(context).colorScheme.primary,
                    ),
                    activeIndex: provider.currentPage,
                    count: provider.onBordingData.length,
                    onDotClicked: (index) {
                      provider.changeIndex(index);
                      provider.carouselController.animateToPage(
                        provider.currentPage,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
