import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';

class Wode extends StatefulWidget {
  const Wode({super.key});

  @override
  State<Wode> createState() => _WodeState();
}

class _WodeState extends State<Wode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Background(imagePath: 'lib/material/background2.png')],
      ),
    );
  }
}
