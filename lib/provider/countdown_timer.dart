import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends ChangeNotifier {
  bool cancel = false;
  bool timeUp = false;

  // bool
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  double progressTick = 0;
  double _convertSecond = 0;

  void stopTimer() {
    seconds = 0;
    minutes = 0;
    hours = 0;
    progressTick = 0;
    _convertSecond = 0;
  }

  void converter() {
    _convertSecond = ((hours * 3600) + (minutes * 60) + seconds + 0.0);
  }

  void countDown() {
    timeUp = false;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // If the values are empty, "IF" is executed
      if (hours == 0 && minutes == 0 && seconds == 0) {
        timer.cancel();
      } else {
        if (cancel) {
          timer.cancel();
        }
        // If the hour comes empty, this section will run
        else if (hours == 0) {
          if (seconds != 0) {
            seconds--;
          }
          if (seconds == 0 && minutes != 0) {
            seconds = 59;
            minutes--;
          } else if (seconds == 0 && minutes == 0) {
            timer.cancel();
            timeUp = true;
          }
        }
        // If the minutes comes empty, this section will run
        else if (minutes == 0) {
          if (seconds != 0) {
            seconds--;
          }
          if (seconds == 0 && hours != 0) {
            seconds = 59;
            minutes = 59;
            hours--;
          }
        }
        // If the second comes empty, this section will run
        else if (seconds == 0) {
          if (seconds != 0) {
            seconds--;
          }
          if (seconds == 0 && minutes != 0) {
            seconds = 59;
            minutes--;
          }
          if (hours != 0 && seconds == 0 && minutes == 0) {
            minutes = 59;
            hours--;
          }
        }
        // If all the values are not empty, this section will be executed
        else if (hours != 0 && minutes != 0 && seconds != 0) {
          if (seconds != 0) {
            seconds--;
          }
        }
        progressTick = (((hours * 3600) + (minutes * 60) + seconds + 0.0) /
            _convertSecond);
      }
      notifyListeners();
    });
  }
}
