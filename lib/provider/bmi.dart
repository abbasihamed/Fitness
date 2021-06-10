import 'package:flutter/cupertino.dart';

class CalculateBMI extends ChangeNotifier {
  String _result = '';
  String _message = '';

  String get result => _result;

  String get message => _message;

  void calculateBmi({required double weight, required double height}) {
    _result = (weight / (height * height)).toStringAsFixed(2);
    double numResult = double.parse(_result);
    if (numResult < 18.5) {
      _message = 'در حال حاضر شما دارای کمبود وزن می باشید';
    } else if (18.5 <= numResult && numResult < 25) {
      _message = 'در حال حاضر شما دارای وزن نرمال می باشید';
    } else if (25 <= numResult && numResult < 25.9) {
      _message = 'در حال حاضر شما دارای اضافه وزن می باشید';
    } else {
      _message = 'در حال حاضر شما دارای چاقی بیش از حد می باشید';
    }
    notifyListeners();
  }
}
