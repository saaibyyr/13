import 'package:flutter/material.dart';
import 'package:flutter_bottom_aierke/presentation/screen/lottie_screen.dart';

import 'package:flutter_bottom_aierke/presentation/screen/post.dart';
import 'package:flutter_bottom_aierke/presentation/screen/qr_screen.dart';

import 'package:lottie/lottie.dart';

void main() => runApp(MaterialApp(home: CustomBottomBar()));

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LottiePage(),
    PostsPage(),
    LottiePage2(),
    QRScanApp(),
  ];

  Color _getIconColor(int index) {
    return _currentIndex == index ? Colors.blue : Colors.grey;
  }

  double _getIconSize(int index) {
    return _currentIndex == index ? 30 : 25;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 10,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.person,
                  color: _getIconColor(0), size: _getIconSize(0)),
            ),
            label: 'Акцент',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.home,
                  color: _getIconColor(1), size: _getIconSize(1)),
            ),
            label: 'Дом',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.work,
                  color: _getIconColor(2), size: _getIconSize(2)),
            ),
            label: 'Работа',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Icon(Icons.music_note,
                  color: _getIconColor(3), size: _getIconSize(3)),
            ),
            label: 'Музыка',
          ),
        ],
      ),
    );
  }
}

class LottiePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset('assets/animate/project1.json',
                width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}

class LottiePage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Lottie.asset('assets/animate/project2.json',
                width: 300, height: 300),
          ],
        ),
      ),
    );
  }
}