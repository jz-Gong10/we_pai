import 'package:flutter/material.dart';

class UpEdge extends StatefulWidget {
  final String title;
  const UpEdge({super.key, required this.title});

  @override
  State<UpEdge> createState() => _UpEdgeState();
}

class _UpEdgeState extends State<UpEdge> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: const Color.fromARGB(255, 0, 0, 0),
              size: 24,
            ),
          ),
        ),

        Expanded(
          flex: 6,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),

        Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
