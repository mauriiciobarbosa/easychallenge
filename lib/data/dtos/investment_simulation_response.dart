import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
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
    initializeDateFormatting('pt_BR');

    final moneyFormatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final percentFormatter =
        NumberFormat.decimalPercentPattern(locale: 'pt_BR', decimalDigits: 2);
    final dateFormatter = DateFormat('dd/MM/yyyy', 'pt_BR');

    return InvestmentSimulationResult(
      grossAmount: moneyFormatter.format(this.grossAmount),
      netAmountProfit: moneyFormatter.format(this.netAmountProfit),
      investedAmount:
          moneyFormatter.format(this.investmentParameter.investedAmount),
      grossAmountProfit: moneyFormatter.format(this.grossAmountProfit),
      incomeTax: '${moneyFormatter.format(this.taxesAmount)} '
          '[${percentFormatter.format(this.taxesRate / 100)}]',
      maturityDate: dateFormatter.format(
        DateTime.parse(this.investmentParameter.maturityDate),
      ),
      period: this.investmentParameter.maturityTotalDays.toString(),
      monthlyGrossRateProfit:
          percentFormatter.format(this.monthlyGrossRateProfit / 100),
      rate: percentFormatter.format(this.investmentParameter.rate / 100),
      annualGrossRateProfit: percentFormatter.format(
        this.annualGrossRateProfit / 100,
      ),
      rateProfit: percentFormatter.format(this.rateProfit / 100),
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
