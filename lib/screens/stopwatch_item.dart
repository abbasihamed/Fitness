import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timer/widget/timers/timer_button.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({Key? key}) : super(key: key);

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final ScrollController _scrollController = ScrollController();
  final _isHour = true;
  bool _isStart = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/image3.jpg'),
                  fit: BoxFit.cover)),
          child: Container(
            color: Colors.black54,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: _stopWatchTimer.rawTime.value,
                    builder: (context, snapshot) {
                      final value = snapshot.data!;
                      final displayTime =
                          StopWatchTimer.getDisplayTime(value, hours: _isHour);
                      return Text(
                        displayTime,
                        style: GoogleFonts.openSans(
                            color: Colors.white, fontSize: 40),
                      );
                    }),
                //Lap Section
                Container(
                  width: size.width * 0.6,
                  height: size.height * 0.35,
                  color: Colors.transparent,
                  child: StreamBuilder<List<StopWatchRecord>>(
                    stream: _stopWatchTimer.records,
                    initialData: _stopWatchTimer.records.value,
                    builder: (context, snap) {
                      final value = snap.data!;
                      if (value.isEmpty) {
                        return Container();
                      }
                      Future.delayed(const Duration(milliseconds: 100), () {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeOut);
                      });
                      return Scrollbar(
                        child: ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final data = value[index];
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '${index + 1} - ${data.displayTime}',
                                    style: GoogleFonts.oswald(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ],
                            );
                          },
                          itemCount: value.length,
                        ),
                      );
                    },
                  ),
                ),
                // Lap Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimerButton(
                      size: size,
                      onPress: () {
                        if (!_isStart) {
                          _isStart = true;
                          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                        } else if (_isStart) {
                          _isStart = false;
                          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                        }
                        setState(() {});
                      },
                      child: Text(
                        _isStart ? 'پایان' : 'شروع',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: _isStart ? Colors.red : Colors.yellowAccent,
                        elevation: 2,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.065,
                    ),
                    TimerButton(
                      size: size,
                      onPress: () async {
                        if (_isStart) {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
                        } else if (!_isStart) {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        }
                      },
                      child: Text(
                        _isStart ? 'دور' : 'مجدد',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: !_isStart ? Colors.white : Colors.yellowAccent,
                        elevation: 2,
                      ),
                    )
                  ],
                )
              ],
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
    _stopWatchTimer.dispose();
  }
}
