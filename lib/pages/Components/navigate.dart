import 'package:flutter/material.dart';

class lastpart extends StatefulWidget {
  const lastpart({super.key});


  @override
  State<lastpart> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<lastpart> {
  int _selectedIndex = 0; // Use lowercase with underscores for private variables.

  final List<BottomNavigationBarItem> _bottomNavItems = [
    // Renamed for clarity and consistency.
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home', // Capitalize first letter for consistency.
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.create),
      label: 'Create',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: 'List',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _bottomNavItems,
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          switch(index)
          {
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
          _selectedIndex = index;
        });
      },
    );
  }
}
