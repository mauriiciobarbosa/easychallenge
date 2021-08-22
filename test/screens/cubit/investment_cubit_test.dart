import 'package:bloc_test/bloc_test.dart';
import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:easynvest_app/screens/cubit/investment_cubit.dart';
import 'package:easynvest_app/screens/cubit/investment_cubit_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../factories.dart';
import 'investment_cubit_test.mocks.dart';

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

  group('#onValueChanged', () {
    blocTest<InvestmentCubit, InvestmentCubitState>(
      'when value is changed',
      build: () => InvestmentCubit(repository: repository),
      act: (cubit) async {
        await cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2025');
      },
      expect: () => [
        InvestmentInitialState(
          amount: 'R\$ 5.999,99',
          rate: '100',
          date: '31/12/2025',
        )
      ],
    );

    blocTest<InvestmentCubit, InvestmentCubitState>(
      'when value is changed on other state than InitialState',
      build: () => InvestmentCubit(repository: repository),
      act: (cubit) async {
        when(repository.doSimulation(any)).thenAnswer((_) async => throw '');
        await cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2020');
        await cubit.doSimulation();
        await cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2025');
      },
      errors: () => [isA<AssertionError>()],
    );
  });

  group('#doSimulation', () {
    blocTest<InvestmentCubit, InvestmentCubitState>(
      'when request is successful',
      build: () => InvestmentCubit(repository: repository),
      act: (cubit) {
        // blocTest - passa callback
        // mockito - não usa callback
        when(repository.doSimulation(any)).thenAnswer((_) async => result);
        cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2025');
        cubit.doSimulation();
      },
      expect: () => [
        InvestmentInitialState(
          amount: 'R\$ 5.999,99',
          rate: '100',
          date: '31/12/2025',
        ),
        InvestmentLoadingState(),
        InvestmentLoadedState(result)
      ],
    );

    blocTest<InvestmentCubit, InvestmentCubitState>(
      'when request fails',
      build: () => InvestmentCubit(repository: repository),
      act: (cubit) async {
        when(repository.doSimulation(any))
            .thenAnswer((_) async => throw Exception('failed'));
        await cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2025');
        await cubit.doSimulation();
      },
      expect: () => [
        InvestmentInitialState(
          amount: 'R\$ 5.999,99',
          rate: '100',
          date: '31/12/2025',
        ),
        InvestmentLoadingState(),
        InvestmentErrorState('Exception: failed')
      ],
    );
  });

  blocTest<InvestmentCubit, InvestmentCubitState>(
    'when go back',
    build: () => InvestmentCubit(repository: repository),
    act: (cubit) async {
      when(repository.doSimulation(any)).thenAnswer((_) async => result);
      await cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2025');
      await cubit.doSimulation();
      await cubit.goBack();
    },
    expect: () => [
      InvestmentInitialState(
        amount: 'R\$ 5.999,99',
        rate: '100',
        date: '31/12/2025',
      ),
      InvestmentLoadingState(),
      InvestmentLoadedState(result),
      InvestmentInitialState(
        amount: 'R\$ 5.999,99',
        rate: '100',
        date: '31/12/2025',
      ),
    ],
  );
}
