import 'package:equatable/equatable.dart';

class InvestmentSimulationResult extends Equatable {
  InvestmentSimulationResult({
    required this.grossAmount,
    required this.netAmountProfit,
    required this.investedAmount,
    required this.grossAmountProfit,
    required this.taxesAmount,
    required this.taxesRate,
    required this.maturityDate,
    required this.period,
    required this.monthlyGrossRateProfit,
    required this.rate,
    required this.annualGrossRateProfit,
    required this.rateProfit,
  });

  final double grossAmount;
  final double netAmountProfit;
  final int investedAmount;
  final double grossAmountProfit;
  final double taxesAmount;
  final double taxesRate;
  final String maturityDate;
  final String period;
  final double monthlyGrossRateProfit;
  final double rate;
  final double annualGrossRateProfit;
  final double rateProfit;

  @override
  List<Object?> get props => [
        grossAmount,
        netAmountProfit,
        investedAmount,
        grossAmountProfit,
        taxesAmount,
        taxesRate,
        maturityDate,
        period,
        monthlyGrossRateProfit,
        rate,
        annualGrossRateProfit,
        rateProfit,
      ];
}
