import 'package:flutter/material.dart';

class ResultHeader extends StatelessWidget {
  ResultHeader({
    required this.grossAmount,
    required this.netAmountProfit,
  });

  final String grossAmount;
  final String netAmountProfit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text('Resultado da simulação'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              grossAmount,
              style: TextStyle(
                fontSize: 48,
              ),
            ),
          ),
          Text('Rendimento total de $netAmountProfit'),
        ],
      ),
    );
  }
}
