import 'package:flutter/material.dart';
import 'package:p_healthy/ui/pages/home/home_page.dart';
import 'package:p_healthy/ui/pages/maps_route/map_route.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  List<Widget> pages = [const HomePage(), const MapPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.map_outlined),
            title: const Text("Maps"),
            selectedColor: Colors.pink,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
