import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/widget/nav_items/stopwatch_item.dart';
import 'package:timer/widget/nav_items/timer_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  List items = [
    const StopWatch(),
    const Timer(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text(
          'فیتکده',
          style: GoogleFonts.ptSerif(
            color: Colors.yellow,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.grey[900],
        elevation: 5,
      ),
      body: items.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[850],
        currentIndex: _currentIndex,
        elevation: 5,
        iconSize: 25,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.yellow,
        unselectedLabelStyle:
            GoogleFonts.oswald(color: Colors.white, letterSpacing: 0.5),
        selectedLabelStyle:
            GoogleFonts.oswald(color: Colors.yellowAccent, letterSpacing: 1),
        selectedIconTheme: const IconThemeData(color: Colors.yellow, size: 30),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.access_time,
              ),
              label: 'کرونومتر'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.access_alarm,
              ),
              label: 'زمان سنج'),
        ],
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
