import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/provider/countdown_timer.dart';
import 'package:timer/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => CountDown())],
      child: const MaterialApp(
        title: 'Timer',
        debugShowCheckedModeBanner: false,
        home: Directionality(
            textDirection: TextDirection.rtl, child: HomeScreen()),
      ),
    );
  }
}
