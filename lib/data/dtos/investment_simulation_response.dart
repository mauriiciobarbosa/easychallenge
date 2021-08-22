import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:json_annotation/json_annotation.dart';

part 'investment_simulation_response.g.dart';

@JsonSerializable()
class InvestmentSimulationResponse {
  InvestmentSimulationResponse({
    required this.investmentParameter,
    required this.grossAmount,
    required this.taxesAmount,
    required this.netAmount,
    required this.grossAmountProfit,
    required this.netAmountProfit,
    required this.annualGrossRateProfit,
    required this.monthlyGrossRateProfit,
    required this.dailyGrossRateProfit,
    required this.taxesRate,
    required this.rateProfit,
    required this.annualNetRateProfit,
  });

  InvestmentParameter investmentParameter;
  double grossAmount;
  double taxesAmount;
  double netAmount;
  double grossAmountProfit;
  double netAmountProfit;
  double annualGrossRateProfit;
  double monthlyGrossRateProfit;
  double dailyGrossRateProfit;
  double taxesRate;
  double rateProfit;
  double annualNetRateProfit;

  factory InvestmentSimulationResponse.fromJson(Map<String, dynamic> json) {
    return _$InvestmentSimulationResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvestmentSimulationResponseToJson(this);
  }

  InvestmentSimulationResult toDomain() {
    return InvestmentSimulationResult(
      grossAmount: this.grossAmount,
      netAmountProfit: this.netAmountProfit,
      investedAmount: this.investmentParameter.investedAmount,
      grossAmountProfit: this.grossAmountProfit,
      taxesAmount: this.taxesAmount,
      taxesRate: this.taxesRate / 100,
      maturityDate: this.investmentParameter.maturityDate,
      period: this.investmentParameter.maturityTotalDays.toString(),
      monthlyGrossRateProfit: this.monthlyGrossRateProfit / 100,
      rate: this.investmentParameter.rate / 100,
      annualGrossRateProfit: this.annualGrossRateProfit / 100,
      rateProfit: this.rateProfit / 100,
    );
  }
}

@JsonSerializable()
class InvestmentParameter {
  InvestmentParameter({
    required this.investedAmount,
    required this.yearlyInterestRate,
    required this.maturityTotalDays,
    required this.maturityBusinessDays,
    required this.maturityDate,
    required this.rate,
    required this.isTaxFree,
  });

  int investedAmount;
  double yearlyInterestRate;
  int maturityTotalDays;
  int maturityBusinessDays;
  String maturityDate;
  double rate;
  bool isTaxFree;

  factory InvestmentParameter.fromJson(Map<String, dynamic> json) {
    return _$InvestmentParameterFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvestmentParameterToJson(this);
  }
}
