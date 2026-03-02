import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  int quality_rating = 0;
  int ontime_rating = 0;
  int talk_rating = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingRow('摄影师拍摄质量', quality_rating, (int value) {
            setState(() {
              quality_rating = value;
            });
          }),
          SizedBox(height: 16),
          _buildRatingRow('摄影师准时性', ontime_rating, (int value) {
            setState(() {
              ontime_rating = value;
            });
          }),
          SizedBox(height: 16),
          _buildRatingRow('沟通效率', talk_rating, (int value) {
            setState(() {
              talk_rating = value;
            });
          }),
          SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // 处理提交逻辑
                print(
                  '拍摄质量: $quality_rating, 准时性: $ontime_rating, 沟通效率: $talk_rating',
                );
              },
              child: Text('提交'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingRow(
    String label,
    int rating,
    Function(int) onRatingChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
              ),
              onPressed: () => onRatingChanged(index + 1),
            );
          }),
        ),
      ],
    );
  }
}
