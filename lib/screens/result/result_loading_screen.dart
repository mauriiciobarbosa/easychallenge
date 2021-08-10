import 'package:easynvest_app/components/result_shimmer_header.dart';
import 'package:easynvest_app/components/result_shimmer_row.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ResultLoadingScreen extends StatelessWidget {
  ResultLoadingScreen({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        leading: IconButton(
          onPressed: onBack,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300] ?? Colors.grey,
          highlightColor: Colors.white,
          child: ListView(
            children: [
              ResultShimmerHeader(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              SizedBox(height: 40),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              ResultShimmerRow(),
              // Button(
              //   text: 'Simular novamente',
              //   onPressed: null,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
