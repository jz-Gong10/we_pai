import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final double value;

  const ProgressIndicator({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value);
  }
}

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: CircularProgressIndicator(color: Color(0x80F98C53)),
    );
  }
}
