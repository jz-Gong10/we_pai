import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';

class Yijianfankui extends StatefulWidget {
  const Yijianfankui({super.key});

  @override
  State<Yijianfankui> createState() => _YijianfankuiState();
}

class _YijianfankuiState extends State<Yijianfankui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Background(imagePath: 'lib/material/background2.png')],
      ),
    );
  }
}
