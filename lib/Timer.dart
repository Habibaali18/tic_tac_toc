import 'package:flutter/material.dart';
import 'dart:async';
import 'colors.dart';

class TimerWedget extends StatefulWidget {
  final bool isRunning;

  const TimerWedget({super.key, this.isRunning = true});

  @override
  State<TimerWedget> createState() => _TimerWedgetState();
}

class _TimerWedgetState extends State<TimerWedget> {
  int secondsElapsed = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (widget.isRunning) {
      startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant TimerWedget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isRunning) {
      stopTimer();
    }
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          secondsElapsed++;
        });
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  String formatTime(int totalSecconds) {
    int minutes = totalSecconds ~/ 60;
    int seconds = totalSecconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondStr = seconds.toString().padLeft(2, '0');
    return "$minutesStr:$secondStr";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        formatTime(secondsElapsed),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.Black,
        ),
      ),
    );
  }
}
