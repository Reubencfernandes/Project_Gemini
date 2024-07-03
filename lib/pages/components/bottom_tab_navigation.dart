import 'package:flutter/material.dart';

class BottomTabNavigation extends StatefulWidget {
  const BottomTabNavigation({super.key});

  @override
  State<BottomTabNavigation> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<BottomTabNavigation> {
  int _selectedIndex = 0;
  PageController _pageController = PageController();
  final List<BottomNavigationBarItem> _bottomNavItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.create),
      label: 'Create',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'Tasks',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BottomNavigationBar(
          items: _bottomNavItems,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              switch (index) {
                case 0:
                  Navigator.pushNamed(context, '/home');
                  break;
                case 1:
                  Navigator.pushNamed(context, '/create');
                  break;
                case 2:
                  Navigator.pushNamed(context, '/tasks');
                  break;
              }
            });
          },
        ),
    );
  }
}
