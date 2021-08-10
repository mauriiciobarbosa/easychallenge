import 'package:equatable/equatable.dart';

class InvestmentSimulationResult extends Equatable {
  InvestmentSimulationResult({
    required this.grossAmount,
    required this.netAmountProfit,
    required this.investedAmount,
    required this.grossAmountProfit,
    required this.incomeTax,
    required this.maturityDate,
    required this.period,
    required this.monthlyGrossRateProfit,
    required this.rate,
    required this.annualGrossRateProfit,
    required this.rateProfit,
  });

  final String grossAmount;
  final String netAmountProfit;
  final String investedAmount;
  final String grossAmountProfit;
  final String incomeTax;
  final String maturityDate;
  final String period;
  final String monthlyGrossRateProfit;
  final String rate;
  final String annualGrossRateProfit;
  final String rateProfit;

  @override
  List<Object?> get props => [
        grossAmount,
        netAmountProfit,
        investedAmount,
        grossAmountProfit,
        incomeTax,
        maturityDate,
        period,
        monthlyGrossRateProfit,
        rate,
        annualGrossRateProfit,
        rateProfit,
      ];
}
