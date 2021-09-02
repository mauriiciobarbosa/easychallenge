import 'package:easychallenge/domain/investment_simulation_result.dart';
import 'package:easychallenge/screens/result/result_arguments.dart';
import 'package:easychallenge/screens/result/result_container.dart';
import 'package:easychallenge/screens/result/result_error_screen.dart';
import 'package:easychallenge/screens/result/result_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/mockito.dart';

import '../../matchers.dart';
import 'cubit/result_investment_cubit.mocks.dart';

void main() {
  late MockInvestmentSimulationRepository repository;
  final InvestmentSimulationResult result = InvestmentSimulationResult(
    grossAmount: 60528.20,
    netAmountProfit: 23974.42,
    investedAmount: 1000,
    grossAmountProfit: 28205.20,
    taxesAmount: 4230.78,
    taxesRate: 0.15,
    maturityDate: '2023-03-21T00:00:00',
    period: '1981',
    monthlyGrossRateProfit: 0.0076,
    rate: 1.23,
    annualGrossRateProfit: 0.8726,
    rateProfit: 0.095512,
  );
  final String grossAmount = 'R\$ 60.528,20';
  final String netAmountProfit = 'R\$ 23.974,42';
  final String investedAmount = 'R\$ 1.000,00';
  final String grossAmountProfit = 'R\$ 28.205,20';
  final String incomeTax = 'R\$ 4.230,78 [15,00%]';
  final String maturityDate = '21/03/2023';
  final String period = '1981';
  final String monthlyGrossRateProfit = '0,76%';
  final String rate = '123,00%';
  final String annualGrossRateProfit = '87,26%';
  final String rateProfit = '9,55%';

  setUp(() {
    repository = MockInvestmentSimulationRepository();

    initializeDateFormatting('pt_BR');
  });

  Future<void> setupContainer(WidgetTester tester, Widget widget) async {
    final key = GlobalKey<NavigatorState>();
    final args = ResultArguments('R\$ 5.999,99', '100', '31/12/2025');
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: key,
        home: TextButton(
          onPressed: () => key.currentState!.push(
            MaterialPageRoute<void>(
              settings: RouteSettings(arguments: args),
              builder: (_) => widget,
            ),
          ),
          child: const SizedBox(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
  }

  testWidgets('when request is successful', (tester) async {
    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    await setupContainer(
      tester,
      ResultContainer(
        repository: repository,
        onBack: expectAsync1((_) {}, count: 0),
      ),
    );

    expect(find.widgetWithText(AppBar, 'Resultado'), findsOneWidget);

    final header = find.byWidgetPredicate(
      (widget) => findHeaderWithGrossAmountAndNetAmountProfit(
          widget, grossAmount, netAmountProfit),
    );
    expect(header, findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor aplicado inicialmente',
          investedAmount,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor bruto do investimento',
          grossAmount,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor do rendimento',
          grossAmountProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'IR sobre o investimento',
          incomeTax,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor líquido do investimento',
          netAmountProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Data de resgate',
          maturityDate,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Dias corridos',
          period,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Rendimento mensal',
          monthlyGrossRateProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Percentual do CDI do investimento',
          rate,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Rentabilidade anual',
          annualGrossRateProfit,
        ),
      ),
      findsOneWidget,
    );

    final finder = find.byWidgetPredicate(
      (widget) => findRowWithTitleAndDescription(
        widget,
        'Rentabilidade no período',
        rateProfit,
      ),
    );
    await tester.scrollUntilVisible(finder, 1);

    expect(finder, findsOneWidget);

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(
        widget,
        'Simular novamente',
        isEnabled: true,
      ),
    );
    expect(button, findsOneWidget);
  });

  testWidgets('when request fails', (tester) async {
    when(repository.doSimulation(any)).thenThrow(Exception('error'));

    await setupContainer(
      tester,
      ResultContainer(
        repository: repository,
        onBack: expectAsync1((_) {}, count: 0),
      ),
    );

    expect(find.widgetWithText(AppBar, 'Resultado'), findsOneWidget);
    expect(find.text('Oooops...'), findsOneWidget);
    expect(
      find.text('Algo não saiu como planejado e as\n informações não foram'
          ' carregadas.'),
      findsOneWidget,
    );

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(
        widget,
        'Tentar novamente',
        isEnabled: true,
      ),
    );
    expect(button, findsOneWidget);
  });

  testWidgets('when request fails and click on try again returns success',
      (tester) async {
    when(repository.doSimulation(any)).thenThrow(Exception('error'));

    await setupContainer(
      tester,
      ResultContainer(
        repository: repository,
        onBack: expectAsync1((_) {}, count: 0),
      ),
    );

    expect(find.byType(ResultErrorScreen), findsOneWidget);

    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(
        widget,
        'Tentar novamente',
        isEnabled: true,
      ),
    );
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.byType(ResultSuccessScreen), findsOneWidget);
  });

  testWidgets('when simulate again button is clicked', (tester) async {
    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    await setupContainer(
      tester,
      ResultContainer(
        repository: repository,
        onBack: expectAsync0(() {}, count: 1),
      ),
    );

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(
        widget,
        'Simular novamente',
        isEnabled: true,
      ),
    );
    await tester.tap(button);
    await tester.pumpAndSettle();
  });

  testWidgets('when back button is clicked', (tester) async {
    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    await setupContainer(
      tester,
      ResultContainer(
        onBack: expectAsync0(() {}, count: 1),
        repository: repository,
      ),
    );

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
  });
}
