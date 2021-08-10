import 'package:flutter/material.dart';

class ResultShimmerRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 180, height: 16, color: Colors.grey),
          Container(width: 60, height: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
