import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestingC extends StatefulWidget {
  const TestingC({super.key});

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String threeDigits(int n) => n.toString().padLeft(3, '0');

    String twoDigitHours = twoDigits(duration.inHours.remainder(24));
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String threeDigitMilliseconds =
        threeDigits(duration.inMilliseconds.remainder(1000));
    String threeDigitMicroseconds =
        threeDigits(duration.inMicroseconds.remainder(1000));

    return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds:$threeDigitMilliseconds:$threeDigitMicroseconds";
  }

  @override
  State<TestingC> createState() => _TestingCState();
}

class _TestingCState extends State<TestingC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icon/motion_photos_paused.svg',
              ),
              SvgPicture.asset(
                'assets/icon/sound_sampler.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Text(
//             formatDuration(_controller.value.position),
//             style: TextStyle(fontSize: 16, color: Colors.white),
//           ),

// Slider(
          //   value: _currentSliderValue,
          //   min: 0,
          //   max: _controller.value.duration.inSeconds.toDouble(),
          //   onChanged: (value) {
          //     setState(() {
          //       _currentSliderValue = value;
          //     });
          //   },
          //   onChangeEnd: (value) {
          //     _controller.seekTo(Duration(seconds: value.toInt()));
          //   },
          // ),
          
          // ValueListenableBuilder(
          //   valueListenable: _sliderValueNotifier,
          //   builder: (context, value, child) {
          //     return Slider(
          //       value: value,
          //       min: 0,
          //       max: _controller.value.duration.inMilliseconds.toDouble(),
          //       onChanged: (value) {
          //         _controller.seekTo(Duration(milliseconds: value.toInt()));
          //       },
          //       onChangeEnd: (value) {
          //         _controller.seekTo(Duration(milliseconds: value.toInt()));
          //       },
          //     );
          //   },
          // ),