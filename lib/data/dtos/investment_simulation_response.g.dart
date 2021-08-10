// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_simulation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestmentSimulationResponse _$InvestmentSimulationResponseFromJson(
    Map<String, dynamic> json) {
  return InvestmentSimulationResponse(
    investmentParameter: InvestmentParameter.fromJson(
        json['investmentParameter'] as Map<String, dynamic>),
    grossAmount: (json['grossAmount'] as num).toDouble(),
    taxesAmount: (json['taxesAmount'] as num).toDouble(),
    netAmount: (json['netAmount'] as num).toDouble(),
    grossAmountProfit: (json['grossAmountProfit'] as num).toDouble(),
    netAmountProfit: (json['netAmountProfit'] as num).toDouble(),
    annualGrossRateProfit: (json['annualGrossRateProfit'] as num).toDouble(),
    monthlyGrossRateProfit: (json['monthlyGrossRateProfit'] as num).toDouble(),
    dailyGrossRateProfit: (json['dailyGrossRateProfit'] as num).toDouble(),
    taxesRate: (json['taxesRate'] as num).toDouble(),
    rateProfit: (json['rateProfit'] as num).toDouble(),
    annualNetRateProfit: (json['annualNetRateProfit'] as num).toDouble(),
  );
}

Map<String, dynamic> _$InvestmentSimulationResponseToJson(
        InvestmentSimulationResponse instance) =>
    <String, dynamic>{
      'investmentParameter': instance.investmentParameter,
      'grossAmount': instance.grossAmount,
      'taxesAmount': instance.taxesAmount,
      'netAmount': instance.netAmount,
      'grossAmountProfit': instance.grossAmountProfit,
      'netAmountProfit': instance.netAmountProfit,
      'annualGrossRateProfit': instance.annualGrossRateProfit,
      'monthlyGrossRateProfit': instance.monthlyGrossRateProfit,
      'dailyGrossRateProfit': instance.dailyGrossRateProfit,
      'taxesRate': instance.taxesRate,
      'rateProfit': instance.rateProfit,
      'annualNetRateProfit': instance.annualNetRateProfit,
    };

InvestmentParameter _$InvestmentParameterFromJson(Map<String, dynamic> json) {
  return InvestmentParameter(
    investedAmount: json['investedAmount'] as int,
    yearlyInterestRate: (json['yearlyInterestRate'] as num).toDouble(),
    maturityTotalDays: json['maturityTotalDays'] as int,
    maturityBusinessDays: json['maturityBusinessDays'] as int,
    maturityDate: json['maturityDate'] as String,
    rate: (json['rate'] as num).toDouble(),
    isTaxFree: json['isTaxFree'] as bool,
  );
}

Map<String, dynamic> _$InvestmentParameterToJson(
        InvestmentParameter instance) =>
    <String, dynamic>{
      'investedAmount': instance.investedAmount,
      'yearlyInterestRate': instance.yearlyInterestRate,
      'maturityTotalDays': instance.maturityTotalDays,
      'maturityBusinessDays': instance.maturityBusinessDays,
      'maturityDate': instance.maturityDate,
      'rate': instance.rate,
      'isTaxFree': instance.isTaxFree,
    };
