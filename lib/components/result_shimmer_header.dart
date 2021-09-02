import 'package:flutter/material.dart';

class ResultShimmerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Container(width: 200, height: 16, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(width: 280, height: 54, color: Colors.grey),
          ),
          Container(width: 240, height: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
