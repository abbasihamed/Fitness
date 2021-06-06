import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/provider/countdown_timer.dart';
import 'package:timer/widget/circular_container.dart';
import 'package:timer/widget/timer_button.dart';
import 'package:timer/widget/timer_textfield.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> with TickerProviderStateMixin {
  TextEditingController hourController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  bool readOnly = false;
  bool _isStart = false;
  bool _isRunning = false;
  AnimationController? _animationController;
  Animation? _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<CountDown>(context);
    final size = MediaQuery.of(context).size;
    if (count.timeUp) {
      _animationController!.reverse();
      count.stopTimer();
      _isStart = false;
      _isRunning = false;
    }
    return Directionality(
      textDirection: TextDirection.ltr,
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.09),
                child: Stack(
                  children: [
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: 380,
                      height: 380,
                      child: Consumer<CountDown>(
                        builder: (context, progress, _) =>
                            CircularProgressIndicator(
                          color: Colors.yellowAccent,
                          value: (progress.progressTick == 0)
                              ? 1
                              : progress.progressTick,
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.002,
                      right: size.width * 0.002,
                      top: size.height * 0.002,
                      bottom: size.height * 0.002,
                      child: Transform(
                        alignment: FractionalOffset.center,
                        transform: Matrix4.identity()
                          ..setEntry(2, 3, 0.005)
                          ..rotateY(pi * _animation!.value),
                        child: _animation!.value <= 0.5
                            ? CircularContainer(
                                size: size,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TimerTextFields(
                                        controller: hourController,
                                        action: TextInputAction.next),
                                    const Text(
                                      ':',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TimerTextFields(
                                        controller: minutesController,
                                        onChange: (value) {
                                          if (int.parse(value) > 59) {
                                            minutesController.clear();
                                          }
                                        },
                                        action: TextInputAction.next),
                                    const Text(':',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    TimerTextFields(
                                        controller: secondController,
                                        onChange: (value) {
                                          if (int.parse(value) > 59) {
                                            hourController.clear();
                                          }
                                        },
                                        action: TextInputAction.done),
                                  ],
                                ),
                              )
                            : CircularContainer(
                                size: size,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()..rotateY(pi),
                                  child: Consumer<CountDown>(
                                      builder: (context, timer, _) {
                                    return Text(
                                      '${timer.hours} : ${timer.minutes} : ${timer.seconds}',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isStart)
                      TimerButton(
                        size: size,
                        margin: EdgeInsets.only(right: size.width * 0.06),
                        onPress: () {
                          _animationController!.reverse();
                          _isRunning = false;
                          _isStart = false;
                          count.stopTimer();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          elevation: 2,
                        ),
                        child: const Text(
                          'پایان',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    !_isStart
                        ? TimerButton(
                            size: size,
                            onPress: () async {
                              if (!_isStart) {
                                if (hourController.text.isNotEmpty ||
                                    minutesController.text.isNotEmpty ||
                                    secondController.text.isNotEmpty) {
                                  _isStart = true;
                                  _isRunning = true;
                                  // If the value are blank, send zero
                                  count.hours = hourController.text.isEmpty
                                      ? 0
                                      : int.parse(hourController.text);
                                  count.minutes = minutesController.text.isEmpty
                                      ? 0
                                      : int.parse(minutesController.text);
                                  count.seconds = secondController.text.isEmpty
                                      ? 0
                                      : int.parse(secondController.text);
                                  //////////////////////
                                  count.countDown();
                                  count.cancel = false;
                                  _animationController!.forward();
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.yellowAccent,
                              elevation: 2,
                            ),
                            child: const Text(
                              'شروع',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        : TimerButton(
                            size: size,
                            onPress: () {
                              if (_isRunning) {
                                _isRunning = false;
                                context.read<CountDown>().cancel = true;
                              } else {
                                _isRunning = true;
                                context.read<CountDown>().cancel = false;
                                context.read<CountDown>().countDown();
                              }
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              primary: _isRunning
                                  ? Colors.white
                                  : Colors.yellowAccent,
                              elevation: 2,
                            ),
                            child: Text(
                              _isRunning ? 'توقف' : 'ادامه',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController!.dispose();
    hourController.dispose();
    minutesController.dispose();
    secondController.dispose();
  }
}
