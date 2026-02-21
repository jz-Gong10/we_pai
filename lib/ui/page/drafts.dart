//草稿箱
import 'package:flutter/material.dart';
import 'package:we_pai/ui/widget/background.dart';
import 'package:we_pai/ui/page/editdraft.dart';
import 'package:we_pai/ui/widget/displaydraft.dart';

class DisplayDrafts extends StatefulWidget {
  const DisplayDrafts({super.key});

  @override
  State<DisplayDrafts> createState() => _DisplayDraftsState();
}

class _DisplayDraftsState extends State<DisplayDrafts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),

      body: Stack(
        children: [
          Background(imagePath: 'lib/material/background2.png'),

          Center(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Displaydraft();
              },
            ),
          ),
        ],
      ),
    );
  }
}
