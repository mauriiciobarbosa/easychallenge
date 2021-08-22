import 'package:easynvest_app/components/button.dart';
import 'package:easynvest_app/components/result_header.dart';
import 'package:easynvest_app/components/result_row.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class ResultSuccessScreen extends StatelessWidget {
  ResultSuccessScreen({
    required this.result,
    required this.onBack,
  });

  final InvestmentSimulationResult result;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR');

    final moneyFormatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final percentFormatter =
        NumberFormat.decimalPercentPattern(locale: 'pt_BR', decimalDigits: 2);
    final dateFormatter = DateFormat('dd/MM/yyyy', 'pt_BR');

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
                grossAmount: moneyFormatter.format(result.grossAmount),
                netAmountProfit: moneyFormatter.format(result.netAmountProfit),
              ),
            ),
            ResultRow(
              title: 'Valor aplicado inicialmente',
              description: moneyFormatter.format(result.investedAmount),
            ),
            ResultRow(
              title: 'Valor bruto do investimento',
              description: moneyFormatter.format(result.grossAmount),
            ),
            ResultRow(
              title: 'Valor do rendimento',
              description: moneyFormatter.format(result.grossAmountProfit),
            ),
            ResultRow(
              title: 'IR sobre o investimento',
              description: '${moneyFormatter.format(result.taxesAmount)} '
                  '[${percentFormatter.format(result.taxesRate)}]',
            ),
            ResultRow(
              title: 'Valor líquido do investimento',
              description: moneyFormatter.format(result.netAmountProfit),
            ),
            SizedBox(height: 40),
            ResultRow(
              title: 'Data de resgate',
              description: dateFormatter.format(
                DateTime.parse(result.maturityDate),
              ),
            ),
            ResultRow(
              title: 'Dias corridos',
              description: result.period,
            ),
            ResultRow(
              title: 'Rendimento mensal',
              description:
                  percentFormatter.format(result.monthlyGrossRateProfit),
            ),
            ResultRow(
              title: 'Percentual do CDI do investimento',
              description: percentFormatter.format(result.rate),
            ),
            ResultRow(
              title: 'Rentabilidade anual',
              description:
                  percentFormatter.format(result.annualGrossRateProfit),
            ),
            ResultRow(
              title: 'Rentabilidade no período',
              description: percentFormatter.format(result.rateProfit),
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
