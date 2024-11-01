import 'dart:async';

import 'package:flutter/material.dart';

class CountDown extends StatefulWidget {
  const CountDown({super.key, required this.dueDate});
  final DateTime dueDate;
  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  int diff = 0;
  Timer? timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final diffNow = widget.dueDate.difference(DateTime.now()).inSeconds;
      if (diffNow < 1) {
        timer.cancel();
      }
      setState(() {
        diff = diffNow;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      diff < 1 ? "Elapsed" : '${diff}s left',
      style: const TextStyle(fontSize: 12),
    );
  }
}
