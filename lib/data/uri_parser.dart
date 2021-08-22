import 'dtos/investment_simulation_request.dart';

class UriParser {
  Uri https(
    String baseUrl,
    InvestmentSimulationRequest request,
  ) {
    try {
      final uri = Uri.parse(baseUrl);
      return uri.replace(queryParameters: request.toJson());
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
