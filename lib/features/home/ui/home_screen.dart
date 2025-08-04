import 'package:flutter/material.dart';
import 'package:movies_app/features/home/logic/home_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=context.read<HomeProvider>();
    return Consumer<HomeProvider>(
      builder: (context,_,_) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).colorScheme.primary,
            currentIndex: provider.currentIndex,
            onTap: (index){
              provider.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: 'home',
                icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                label: 'search',
                icon: Icon(Icons.search)
              ),
              BottomNavigationBarItem(
                label: 'favorite',
                icon: Icon(Icons.favorite)
              ),
            ]
          ),
          body: provider.screens[provider.currentIndex] 
        );
      }
    );
  }
}
