import 'package:bloc_test/bloc_test.dart';
import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:easynvest_app/screens/result/cubit/result_investment_cubit.dart';
import 'package:easynvest_app/screens/result/cubit/result_investment_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../factories.dart';
import 'result_investment_cubit.mocks.dart';

@GenerateMocks([InvestmentSimulationRepository])
void main() {
  late MockInvestmentSimulationRepository repository;
  final InvestmentSimulationResult result = mockInvestmentSimulationResponse(
    investmentParameter:
        mockInvestmentParameter(maturityDate: '2023-03-03T00:00:00'),
  ).toDomain();

  setUp(() {
    initializeDateFormatting('pt_BR');
    repository = MockInvestmentSimulationRepository();
  });

  group('#doSimulation', () {
    blocTest<ResultInvestmentCubit, ResultInvestmentCubitState>(
      'when request is successful',
      build: () => ResultInvestmentCubit(repository: repository),
      act: (cubit) {
        // blocTest - passa callback
        // mockito - não usa callback
        when(repository.doSimulation(any)).thenAnswer((_) async => result);
        cubit.doSimulation('R\$ 5.999,99', '100', '31/12/2025');
      },
      expect: () => [
        ResultInvestmentLoadingState(),
        ResultInvestmentLoadedState(result)
      ],
    );

    blocTest<ResultInvestmentCubit, ResultInvestmentCubitState>(
      'when request fails',
      build: () => ResultInvestmentCubit(repository: repository),
      act: (cubit) async {
        when(repository.doSimulation(any))
            .thenAnswer((_) async => throw Exception('failed'));
        await cubit.doSimulation('R\$ 5.999,99', '100', '31/12/2025');
      },
      expect: () => [
        ResultInvestmentLoadingState(),
        ResultInvestmentErrorState('Exception: failed')
      ],
    );
  });
}
