import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/screens/bmi_page.dart';
import 'package:timer/screens/stopwatch_item.dart';
import 'package:timer/screens/timer_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/image1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black54,
          ),
          Center(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: 500,
              height: 500,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 50,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
                padding: EdgeInsets.only(
                    left: size.width * 0.1,
                    right: size.width * 0.1,
                    top: size.height * 0.1),
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Timer()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/icons/timer.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StopWatch()));
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: size.height * 0.015),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/icons/stopwatch.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      'BMI',
                      style: GoogleFonts.oswald(
                          color: Colors.white70, fontSize: 40),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BmiScreens()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        'BMI',
                        style: GoogleFonts.oswald(
                            color: Colors.white70, fontSize: 40),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
