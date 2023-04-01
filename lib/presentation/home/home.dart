import 'dart:io';

import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:thriftly/presentation/feed/feed.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  PageController _pageController = new PageController(initialPage: 0);

  void onTapTapped(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 250), curve: Curves.ease);
    setState(() {
      _currentIndex = index;
    });
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  EdgeInsets padding = Platform.isIOS
      ? const EdgeInsets.only(left: 10, right: 10)
      : const EdgeInsets.only(left: 10, right: 10);

  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = Color(0xff060D14);
  Color unselectedColor = Color(0xff060D14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        children: [
          Feed(),
          Container(
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
          ),
          Container(
            color: Colors.white,
          ),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        height: 60,
        backgroundColor:
            const Color(0xff0BA400), // Color.fromARGB(255, 139, 205, 141),
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _currentIndex,
        onTap: (index) async {
          _pageController.animateToPage(index,
              duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 35), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart, size: 35), label: 'shop'),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 35), label: "add"),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 35), label: 'profile'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
