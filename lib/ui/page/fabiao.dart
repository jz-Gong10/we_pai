import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';

class Fabiao extends StatefulWidget {
  const Fabiao({super.key});

  @override
  State<Fabiao> createState() => _FabiaoState();
}

class _FabiaoState extends State<Fabiao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [Background(imagePath: 'lib/material/background2.png')],
      ),
    );
  }
}
