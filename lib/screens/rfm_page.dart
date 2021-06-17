import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/provider/bmi_and_rfm_calc.dart';
import 'package:timer/widget/bmi/bmi_textfields.dart';
import 'package:timer/widget/timers/timer_button.dart';

class RFMScreen extends StatefulWidget {
  const RFMScreen({Key? key}) : super(key: key);

  @override
  State<RFMScreen> createState() => _RFMScreenState();
}

class _RFMScreenState extends State<RFMScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController waistController = TextEditingController();

  String radioGroup = 'gender';
  int _value = 1;
  double _calOpacity = 0;
  bool _opacity = false;

  @override
  Widget build(BuildContext context) {
    final rfm = Provider.of<CalculateBMIAndRFM>(context);
    final size = MediaQuery.of(context).size;
    print('build');
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/image6.jpg'),
                    fit: BoxFit.cover),
              ),
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
                                'شاخص چربی بدن (RFM) مقیاسی است که به شما میزان چربی بدنتون بصورت تقریبی نمایش میده و شما رو از سطح چربی بدنتون مطلع میکنه.',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    _value = int.parse(value.toString());
                                    setState(() {});
                                  },
                                  activeColor: Colors.yellowAccent,
                                ),
                                const Text(
                                  'زن',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                Radio(
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    _value = int.parse(value.toString());
                                    setState(() {});
                                  },
                                  activeColor: Colors.yellowAccent,
                                ),
                                const Text(
                                  'مرد',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                            BmiTextFields(
                              hintText: 'قد (برحسب سانتی متر)',
                              controller: heightController,
                              textInputAction: TextInputAction.next,
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                  vertical: size.height * 0.02),
                            ),
                            BmiTextFields(
                              onSubmitted: (value) {
                                if (heightController.text.isNotEmpty &&
                                    waistController.text.isNotEmpty) {
                                  rfm.calculateRfm(
                                      height:
                                          double.parse(heightController.text),
                                      waist: double.parse(waistController.text),
                                      gender: _value);
                                  _calOpacity = 1;
                                  setState(() {});
                                }
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              },
                              hintText: 'دور کمر',
                              controller: waistController,
                              textInputAction: TextInputAction.next,
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.1,
                                  vertical: size.height * 0.05),
                            ),
                            TimerButton(
                              onPress: () {
                                if (heightController.text.isNotEmpty &&
                                    waistController.text.isNotEmpty) {
                                  rfm.calculateRfm(
                                      height:
                                          double.parse(heightController.text),
                                      waist: double.parse(waistController.text),
                                      gender: _value);
                                  _calOpacity = 1;
                                  setState(() {});
                                }
                              },
                              size: size,
                              child: const Text(
                                'محاسبه',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.yellowAccent, elevation: 5),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              width: size.width,
                              height: size.height * 0.2,
                              child: rfm.rfmResult.isNotEmpty
                                  ? AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: _calOpacity,
                                      child: Column(
                                        children: [
                                          Text(
                                            'درصد چربی بدن شما ${rfm.rfmResult}% می باشد ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            rfm.rfmMessage,
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
                    )
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
    waistController.dispose();
  }
}
