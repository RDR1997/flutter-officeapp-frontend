import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Page1(),
          Page2(),
          Page3(),
          Page4(),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _selectedIndex,
          dotIndicatorColor: HexColor('#f5f5f5'),
          unselectedItemColor:HexColor('#f5f5f5'),
          selectedItemColor: HexColor('#f5f5f5'),
          splashBorderRadius: 50,
          backgroundColor:HexColor('#30a6d6'),
          // enableFloatingNavBar: false,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease);
            });
          },
          items: [
            /// Home
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
            ),

            /// Likes
            DotNavigationBarItem(
              icon: const Icon(Icons.favorite),
            ),

            /// Search
            DotNavigationBarItem(
              icon: const Icon(Icons.search),
            ),

            /// Profile
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 1'),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 2'),
    );
  }
}

class Page3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 3'),
    );
  }
}

class Page4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Page 4'),
    );
  }
}
