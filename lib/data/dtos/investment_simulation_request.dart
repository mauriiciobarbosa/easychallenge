import 'package:json_annotation/json_annotation.dart';

part 'investment_simulation_request.g.dart';

@JsonSerializable()
class InvestmentSimulationRequest {
  InvestmentSimulationRequest({
    required this.investedAmount,
    required this.rate,
    required this.maturityDate,
    this.index = 'CDI',
    this.isTaxFree = 'false',
  });

  String investedAmount;
  String rate;
  String maturityDate;
  String index;
  String isTaxFree;

  factory InvestmentSimulationRequest.fromJson(Map<String, dynamic> json) {
    return _$InvestmentSimulationRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$InvestmentSimulationRequestToJson(this);
  }
}
