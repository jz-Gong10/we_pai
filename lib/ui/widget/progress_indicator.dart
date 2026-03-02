import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final double value;

  const ProgressIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value);
  }
}

class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: CircularProgressIndicator(color: Color(0x80F98C53)),
    );
  }
}
