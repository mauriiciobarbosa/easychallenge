// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_simulation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestmentSimulationRequest _$InvestmentSimulationRequestFromJson(
    Map<String, dynamic> json) {
  return InvestmentSimulationRequest(
    investedAmount: (json['investedAmount'] as num).toDouble(),
    rate: (json['rate'] as num).toDouble(),
    maturityDate: json['maturityDate'] as String,
    index: json['index'] as String,
    isTaxFree: json['isTaxFree'] as bool,
  );
}

Map<String, dynamic> _$InvestmentSimulationRequestToJson(
        InvestmentSimulationRequest instance) =>
    <String, dynamic>{
      'investedAmount': instance.investedAmount,
      'rate': instance.rate,
      'maturityDate': instance.maturityDate,
      'index': instance.index,
      'isTaxFree': instance.isTaxFree,
    };
