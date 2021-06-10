import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/provider/bmi.dart';
import 'package:timer/widget/bmi/bmi_textfields.dart';
import 'package:timer/widget/timers/timer_button.dart';
import 'package:provider/provider.dart';

class BmiScreens extends StatefulWidget {
  const BmiScreens({Key? key}) : super(key: key);

  @override
  State<BmiScreens> createState() => _BmiScreensState();
}

class _BmiScreensState extends State<BmiScreens> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  bool _opacity = false;
  double _calOpacity = 0;

  @override
  Widget build(BuildContext context) {
    final bmi = Provider.of<CalculateBMI>(context);
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            // ignore: sized_box_for_whitespace
            child: Container(
              width: size.width,
              height: size.height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/image6.jpg'),
                      fit: BoxFit.cover)),
              child: Container(
                color: Colors.black54,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: size.width * 0.02, top: size.height * 0.045),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _opacity = !_opacity;
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.error,
                              size: 28,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: _opacity ? 1 : 0,
                            child: Container(
                              width: size.width * 0.8,
                              height: size.height * 0.11,
                              padding:
                                  EdgeInsets.only(right: size.width * 0.011),
                              margin: EdgeInsets.only(
                                  right: size.width * 0.03,
                                  top: size.height * 0.02),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.white10,
                              ),
                              child: const Text(
                                'شاخص حجم بدن (BMI) مقیاسی است که شما میتوانید متوجه شوید که آیا دچار کمبود وزن، چاقی هستید یا وزن شما نرمال می باشد.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        width: size.width,
                        height: size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BmiTextFields(
                              controller: weightController,
                              hintText: 'وزن',
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1),
                              textInputAction: TextInputAction.next,
                            ),
                            BmiTextFields(
                              onSubmitted: (value) {
                                if (weightController.text.isNotEmpty &&
                                    heightController.text.isNotEmpty) {
                                  context.read<CalculateBMI>().calculateBmi(
                                      weight:
                                          double.parse(weightController.text),
                                      height:
                                          double.parse(heightController.text));
                                  _calOpacity = 1;
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  setState(() {});
                                }
                              },
                              controller: heightController,
                              hintText: 'قد (برحسب متر)',
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                  vertical: size.height * 0.07),
                              textInputAction: TextInputAction.done,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TimerButton(
                                  onPress: () {
                                    if (weightController.text.isNotEmpty &&
                                        heightController.text.isNotEmpty) {
                                      context.read<CalculateBMI>().calculateBmi(
                                          weight: double.parse(
                                              weightController.text),
                                          height: double.parse(
                                              heightController.text));
                                      _calOpacity = 1;
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      setState(() {});
                                    }
                                  },
                                  child: const Text(
                                    'محاسبه',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.yellowAccent,
                                    elevation: 2,
                                  ),
                                  size: size,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: size.height * 0.02),
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              width: size.width,
                              height: size.height * 0.2,
                              child: bmi.result.isNotEmpty
                                  ? AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: _calOpacity,
                                      child: Column(
                                        children: [
                                          Text(
                                            'شاخص حجم بدن شما :  ${bmi.result}  می باشد',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            bmi.message,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                    )
                                  : const Text(''),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    heightController.dispose();
    weightController.dispose();
  }
}
