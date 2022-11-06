import 'package:eve_flutter/view/fav_page.dart';
import 'package:eve_flutter/view/home_page.dart';
import 'package:flutter/material.dart';


class MainPage extends StatefulWidget {

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex  = 0;
 List<Widget> _pages = [
   HomePage(),
   FavPage()
 ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
          onTap: (int index){
          setState(() {
            _currentIndex = index;
          });
          },
          items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.videocam),
          label: 'Home'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
          label: 'Favourites'
        ),

      ]),
    );
  }
}
