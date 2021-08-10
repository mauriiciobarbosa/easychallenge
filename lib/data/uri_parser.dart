import 'dtos/investment_simulation_request.dart';

class UriParser {
  Uri https(
    String baseUrl,
    String path,
    InvestmentSimulationRequest request,
  ) {
    try {
      String params = '?investedAmount=${request.investedAmount}'
          '&index=${request.index}'
          '&rate=${request.rate}'
          '&isTaxFree=${request.isTaxFree}'
          '&maturityDate=${request.maturityDate}';
      return Uri.parse(baseUrl + path + params);
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
