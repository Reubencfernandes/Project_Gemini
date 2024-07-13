import 'package:ayumi/pages/create_task_page.dart';
import 'package:ayumi/pages/home_page.dart';
import 'package:ayumi/pages/tasks_page.dart';
import 'package:flutter/material.dart';

class BottomTabNavigation extends StatefulWidget {
  const BottomTabNavigation({super.key});

  @override
  State<BottomTabNavigation> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<BottomTabNavigation> {
  int _selectedIndex = 0;
  final List<Widget> _pageList = [
    const HomePage(),
    const CreateTaskPage(),
    const TasksPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: _pageList[_selectedIndex],/*IndexedStack(
        children: _pageList,
        index: _selectedIndex,
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 15,color: Colors.black),
        unselectedLabelStyle: const TextStyle(fontSize: 15),
          currentIndex: _selectedIndex,
          onTap:_onItemTapped,
          selectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),
        ],
      ),
    );
  }
}
