import 'dart:convert';

import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/data/uri_parser.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../factories.dart';
import 'investment_simulation_repository_test.mocks.dart';

@GenerateMocks([Client, UriParser])
void main() {
  late MockClient client;
  late MockUriParser uriParser;
  late InvestmentSimulationRepository repository;

  setUp(() {
    client = MockClient();
    uriParser = MockUriParser();
    repository = InvestmentSimulationRepository(
      client: client,
      baseUrl: null,
      uriParser: uriParser,
    );

    when(uriParser.https(any, any, any)).thenAnswer((_) => Uri());
  });

  test('when request is successful', () async {
    // should retrieve a domain object
    final response = mockInvestmentSimulationResponse(
      investmentParameter: mockInvestmentParameter(
        investedAmount: 1000,
        yearlyInterestRate: 9.5512,
        maturityTotalDays: 1981,
        maturityBusinessDays: 1409,
        maturityDate: '2023-03-21T00:00:00',
        rate: 123.0,
        isTaxFree: false,
      ),
      grossAmount: 60528.20,
      taxesAmount: 4230.78,
      netAmount: 56297.42,
      grossAmountProfit: 28205.20,
      netAmountProfit: 23974.42,
      annualGrossRateProfit: 87.26,
      monthlyGrossRateProfit: 0.76,
      dailyGrossRateProfit: 0.000445330025305748,
      taxesRate: 15.0,
      rateProfit: 9.5512,
      annualNetRateProfit: 74.17,
    );
    final expectedResult = InvestmentSimulationResult(
      grossAmount: 'R\$ 60.528,20',
      netAmountProfit: 'R\$ 23.974,42',
      investedAmount: 'R\$ 1.000,00',
      grossAmountProfit: 'R\$ 28.205,20',
      incomeTax: 'R\$ 4.230,78 [15,00%]',
      maturityDate: '21/03/2023',
      period: '1981',
      monthlyGrossRateProfit: '0,76%',
      rate: '123,00%',
      annualGrossRateProfit: '87,26%',
      rateProfit: '9,55%',
    );

    when(client.get(any)).thenAnswer(
      (_) async => Response(jsonEncode(response), 200),
    );

    final actualResponse =
        await repository.doSimulation(mockInvestmentSimulationRequest());

    verify(client.get(any)).called(1);
    expect(actualResponse, expectedResult);
  });

  test('when request fails', () async {
    final request = mockInvestmentSimulationRequest();
    when(client.get(any)).thenThrow(Exception('any error'));

    expect(repository.doSimulation(request), throwsException);
  });
}
