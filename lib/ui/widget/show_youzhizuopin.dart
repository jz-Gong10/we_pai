import 'package:flutter/material.dart';

class ShowYouzhizuopin extends StatefulWidget {
  final String imageURL;
  const ShowYouzhizuopin({super.key, required this.imageURL});

  @override
  State<ShowYouzhizuopin> createState() => _ShowYouzhizuopinState();
}

class _ShowYouzhizuopinState extends State<ShowYouzhizuopin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 385,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      child: Image.network(widget.imageURL),
    );
  }
}
