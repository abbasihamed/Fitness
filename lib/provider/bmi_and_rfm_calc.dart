import 'package:flutter/cupertino.dart';

class CalculateBMIAndRFM extends ChangeNotifier {
  String _bmiResult = '';
  String _bmiMessage = '';
  String _rfmResult = '';
  String _rfmMessage = '';


  String get bmiResult => _bmiResult;

  String get bmiMessage => _bmiMessage;

  String get rfmResult => _rfmResult;

  String get rfmMessage => _rfmMessage;

  void calculateBmi({required double weight, required double height}) {
    _bmiResult = (weight / (height * height)).toStringAsFixed(2);
    double numResult = double.parse(_bmiResult);
    if (numResult < 18.5) {
      _bmiMessage = 'در حال حاضر شما دارای کمبود وزن می باشید';
    } else if (18.5 <= numResult && numResult < 25) {
      _bmiMessage = 'در حال حاضر شما دارای وزن نرمال می باشید';
    } else if (25 <= numResult && numResult < 25.9) {
      _bmiMessage = 'در حال حاضر شما دارای اضافه وزن می باشید';
    } else {
      _bmiMessage = 'در حال حاضر شما دارای چاقی بیش از حد می باشید';
    }
    notifyListeners();
  }

  void calculateRfm(
      {required double height, required double waist, required int gender}) {
    switch (gender) {
      case 1:
        _rfmResult = (76 - (20 * height / waist)).toStringAsFixed(2);
        double numResult = double.parse(_rfmResult);
        if (numResult < 10) {
          _rfmMessage = 'شما دارای چربی خیلی کم هستید';
        } else if (10 <= numResult && numResult <= 13) {
          _rfmMessage = 'شما دارای چربی ضروری هستید';
        } else if (14 <= numResult && numResult <= 20) {
          _rfmMessage = 'شما دارای چربی ورزشکاری هستید';
        } else if (21 <= numResult && numResult <= 24) {
          _rfmMessage = 'شما دارای چربی متناسب هستید';
        } else if (25 <= numResult && numResult <= 31) {
          _rfmMessage = 'شما دارای چربی متوسط هستید';
        } else if (numResult >= 32) {
          _rfmMessage = 'شما درای چربی زیاد هستید';
        }
        break;
      case 2:
        _rfmResult = (64 - (20 * height / waist)).toStringAsFixed(2);
        double numResult = double.parse(_rfmResult);
        if (numResult < 2) {
          _rfmMessage = 'شما دارای چربی خیلی کم هستید';
        } else if (2 <= numResult && numResult <= 5) {
          _rfmMessage = 'شما دارای چربی ضروری هستید';
        } else if (6 <= numResult && numResult <= 13) {
          _rfmMessage = 'شما دارای چربی ورزشکاری هستید';
        } else if (14 <= numResult && numResult <= 17) {
          _rfmMessage = 'شما دارای چربی متناسب هستید';
        } else if (18 <= numResult && numResult <= 24) {
          _rfmMessage = 'شما دارای چربی متوسط هستید';
        } else if (numResult >= 25) {
          _rfmMessage = 'شما درای چربی زیاد هستید';
        }
    }
  }
}
