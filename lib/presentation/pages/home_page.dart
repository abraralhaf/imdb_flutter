import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:movie_package/presentation/pages/home_movie_page.dart';
import 'package:tv_series_imdb/common/constants.dart';
import 'package:tv_series_imdb/presentation/pages/about_page.dart';
import 'package:tv_series_imdb/presentation/pages/home_tv_page.dart';
import 'package:tv_series_imdb/presentation/pages/watchlist_tv_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  final List<Widget> _listWidget = [HomeTvPage(), HomeMoviePage(), AboutPage()];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.ticket_star),
      activeIcon: Icon(
        IconlyBold.ticket_star,
        color: kExoticBlack,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.ticket),
      activeIcon: Icon(IconlyBold.ticket),
      label: 'Movie',
    ),
    BottomNavigationBarItem(
      icon: Icon(IconlyLight.setting),
      activeIcon: Icon(IconlyBold.setting),
      label: 'Settings',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: SizedBox(
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _bottomNavIndex,
          items: _bottomNavBarItems,
          onTap: _onBottomNavTapped,
        ),
      ),
    );
  }
}
