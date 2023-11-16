import 'package:codexia_e_learning/course/ui/show_course_screen.dart';
import 'package:codexia_e_learning/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class NavigationBarScreen extends StatefulWidget {
  const NavigationBarScreen({super.key});

  @override
  State<NavigationBarScreen> createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  List<Widget> screenList=[
    const ShowCourseScreen(),
    const ProfileScreen(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:screenList[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor:  Colors.purple,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: const IconThemeData(color: Colors.purple),
        unselectedItemColor: Colors.black54,
        unselectedLabelStyle: const TextStyle(
          color: Colors.black54,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.black54,
          size: 20,
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile'),
        ],
        onTap: (int index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
      ),
    );
  }
}