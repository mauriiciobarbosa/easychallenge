import 'package:easynvest_app/data/dtos/investment_simulation_request.dart';
import 'package:easynvest_app/data/dtos/investment_simulation_response.dart';

InvestmentSimulationRequest mockInvestmentSimulationRequest({
  double investedAmount = 0,
  double rate = 0,
  String maturityDate = '',
}) {
  return InvestmentSimulationRequest(
    investedAmount: investedAmount.toString(),
    rate: rate.toString(),
    maturityDate: maturityDate,
  );
}

InvestmentSimulationResponse mockInvestmentSimulationResponse({
  required InvestmentParameter investmentParameter,
  double grossAmount = 0,
  double taxesAmount = 0,
  double netAmount = 0,
  double grossAmountProfit = 0,
  double netAmountProfit = 0,
  double annualGrossRateProfit = 0,
  double monthlyGrossRateProfit = 0,
  double dailyGrossRateProfit = 0,
  double taxesRate = 0,
  double rateProfit = 0,
  double annualNetRateProfit = 0,
}) {
  return InvestmentSimulationResponse(
    investmentParameter: investmentParameter,
    grossAmount: grossAmount,
    taxesAmount: taxesAmount,
    netAmount: netAmount,
    grossAmountProfit: grossAmountProfit,
    netAmountProfit: netAmountProfit,
    annualGrossRateProfit: annualGrossRateProfit,
    monthlyGrossRateProfit: monthlyGrossRateProfit,
    dailyGrossRateProfit: dailyGrossRateProfit,
    taxesRate: taxesRate,
    rateProfit: rateProfit,
    annualNetRateProfit: annualNetRateProfit,
  );
}

InvestmentParameter mockInvestmentParameter({
  int investedAmount = 0,
  double yearlyInterestRate = 0,
  int maturityTotalDays = 0,
  int maturityBusinessDays = 0,
  String maturityDate = '',
  double rate = 0,
  bool isTaxFree = false,
}) {
  return InvestmentParameter(
    investedAmount: investedAmount,
    yearlyInterestRate: yearlyInterestRate,
    maturityTotalDays: maturityTotalDays,
    maturityBusinessDays: maturityBusinessDays,
    maturityDate: maturityDate,
    rate: rate,
    isTaxFree: isTaxFree,
  );
}
