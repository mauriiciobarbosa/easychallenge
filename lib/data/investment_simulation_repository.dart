import 'dart:convert';
import 'dart:io';

import 'package:easychallenge/data/dtos/investment_simulation_request.dart';
import 'package:easychallenge/data/dtos/investment_simulation_response.dart';
import 'package:easychallenge/data/uri_parser.dart';
import 'package:easychallenge/domain/investment_simulation_result.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

import 'logging_interceptor.dart';

class InvestmentSimulationRepository {
  InvestmentSimulationRepository({
    Client? client,
    String? baseUrl,
    UriParser? uriParser,
  })  : _client = client ??
            InterceptedClient.build(
              interceptors: [LoggingInterceptor()],
              requestTimeout: Duration(seconds: 30),
            ),
        _baseUrl = baseUrl ??
            'https://610bd12966dd8f0017b76ac2.mockapi.io/'
                'api/investments/simulate/v1',
        _uriParser = uriParser ?? UriParser();

  Client _client;
  String _baseUrl;
  UriParser _uriParser;

  Future<InvestmentSimulationResult> doSimulation(
    InvestmentSimulationRequest request,
  ) async {
    final url = _uriParser.https(_baseUrl, request);

    Response response = await _client.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return InvestmentSimulationResponse.fromJson(body).toDomain();
    }

    throw HttpException(
      'Request failed with status code ${response.statusCode}',
    );
  }
}
