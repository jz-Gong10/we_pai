import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';

class Ruzhu extends StatefulWidget {
  const Ruzhu({super.key});

  @override
  State<Ruzhu> createState() => _RuzhuState();
}

class _RuzhuState extends State<Ruzhu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Background(imagePath: 'lib/material/background2.png')],
      ),
    );
  }
}
