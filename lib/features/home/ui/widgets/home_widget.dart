import 'package:flutter/material.dart';
import 'package:movies_app/features/home/ui/widgets/movies_widget.dart';
import 'package:movies_app/features/home/ui/widgets/trending.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text('Trending Movies',style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(
                height: 270,
                child: TrendingWidget()),
              MoviesWidget()
            ],
          ),
        ),
      ),
    );
  }
}