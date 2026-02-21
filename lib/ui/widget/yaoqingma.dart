import 'package:flutter/material.dart';

class Yaoqingma extends StatefulWidget {
  final TextEditingController controller;

  const Yaoqingma({super.key, required this.controller});

  @override
  State<Yaoqingma> createState() => _YaoqingmaState();
}

class _YaoqingmaState extends State<Yaoqingma> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 64,
      decoration: BoxDecoration(
        color: const Color.fromARGB(125, 255, 255, 255),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Image.asset(
            'lib/material/camera.png',
            color: Colors.black,
          ),
          hintText: '请输入邀请码',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}
