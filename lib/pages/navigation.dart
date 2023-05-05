import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:survey/pages/feedback.dart';
import 'package:survey/pages/homePage.dart';
import 'package:survey/pages/settings.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 1;
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = new PageController(
      initialPage: 1,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color navigationColor = Colors.blue.shade200;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.white,
        color: Colors.white,
        buttonBackgroundColor: Colors.blue.shade900,
        animationDuration: Duration(
          milliseconds: 300,
        ),
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        index: _currentIndex,
        items: <Widget>[
          Icon(
            Icons.feedback_rounded,
            size: 30,
            color: _currentIndex != 0 ? navigationColor : Colors.white,
          ),
          Icon(
            Icons.home,
            size: 30,
            color: _currentIndex != 1 ? navigationColor : Colors.white,
          ),
          Icon(
            Icons.account_circle_rounded,
            size: 30,
            color: _currentIndex != 2 ? navigationColor : Colors.white,
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            FeedbackScreen(),
            //Main
            HomePage(),
            Settings(),
          ],
        ),
      ),
    );
  }
}
