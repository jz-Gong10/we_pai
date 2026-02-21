//草稿箱
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/button.dart';
import 'package:we_pai/ui/themes/colors.dart';
import 'package:we_pai/ui/page/editdraft.dart';

class Displaydraft extends StatefulWidget {
  const Displaydraft({super.key});

  @override
  State<Displaydraft> createState() => _DisplaydraftState();
}

class _DisplaydraftState extends State<Displaydraft> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 389,
      height: 158,
      decoration: BoxDecoration(
        color: primary1, 
        border: Border.all(color: primary2,width: 1), 
        borderRadius: BorderRadius.circular(10), 
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                '上次编辑：年月日',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: EditButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Editdraft()),
                );
              }),
            ),
          ),
        ],
      ),
      
    );
  }
}