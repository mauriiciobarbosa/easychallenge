import 'package:easynvest_app/components/button.dart';
import 'package:easynvest_app/components/result_header.dart';
import 'package:easynvest_app/components/result_row.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:flutter/material.dart';

class ResultSuccessScreen extends StatelessWidget {
  ResultSuccessScreen({
    required this.result,
    required this.onBack,
  });

  final InvestmentSimulationResult result;
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: ResultHeader(
                grossAmount: result.grossAmount,
                netAmountProfit: result.netAmountProfit,
              ),
            ),
            ResultRow(
              title: 'Valor aplicado inicialmente',
              description: result.investedAmount,
            ),
            ResultRow(
              title: 'Valor bruto do investimento',
              description: result.grossAmount,
            ),
            ResultRow(
              title: 'Valor do rendimento',
              description: result.grossAmountProfit,
            ),
            ResultRow(
              title: 'IR sobre o investimento',
              description: result.incomeTax,
            ),
            ResultRow(
              title: 'Valor líquido do investimento',
              description: result.netAmountProfit,
            ),
            SizedBox(height: 40),
            ResultRow(
              title: 'Data de resgate',
              description: result.maturityDate,
            ),
            ResultRow(
              title: 'Dias corridos',
              description: result.period,
            ),
            ResultRow(
              title: 'Rendimento mensal',
              description: result.monthlyGrossRateProfit,
            ),
            ResultRow(
              title: 'Percentual do CDI do investimento',
              description: result.rate,
            ),
            ResultRow(
              title: 'Rentabilidade anual',
              description: result.annualGrossRateProfit,
            ),
            ResultRow(
              title: 'Rentabilidade no período',
              description: result.rateProfit,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 8),
              child: Button(
                text: 'Simular novamente',
                onPressed: onBack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
