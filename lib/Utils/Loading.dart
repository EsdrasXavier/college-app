import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart' as LoadingSdk;

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingSdk.Loading(
        indicator: BallPulseIndicator(), size: 50.0, color: Colors.black);
  }
}
