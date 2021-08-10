import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:easynvest_app/screens/cubit/investment_cubit.dart';
import 'package:easynvest_app/screens/result/result_container.dart';
import 'package:easynvest_app/screens/result/result_error_screen.dart';
import 'package:easynvest_app/screens/result/result_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mockito/mockito.dart';

import '../../matchers.dart';
import '../cubit/investment_cubit_test.mocks.dart';

void main() {
  late MockInvestmentSimulationRepository repository;
  final InvestmentSimulationResult result = InvestmentSimulationResult(
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

  late InvestmentCubit cubit;

  setUp(() {
    repository = MockInvestmentSimulationRepository();
    cubit = InvestmentCubit(repository: repository);
    cubit.onValueChanged('R\$ 5.999,99', '100', '31/12/2025');

    initializeDateFormatting('pt_BR');
  });

  MaterialApp setupContainer(Widget widget) {
    return MaterialApp(
      home: BlocProvider<InvestmentCubit>(
        create: (context) => cubit,
        child: widget,
      ),
    );
  }

  // quando o repositório responder sucesso, deve mostrar a tela preenchida e com o botão de simular novamente.
  testWidgets('when request is successful', (tester) async {
    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    await tester.pumpWidget(setupContainer(
      ResultContainer(
        onBack: expectAsync1((_) {}, count: 0),
      ),
    ));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(AppBar, 'Resultado'), findsOneWidget);

    final header = find.byWidgetPredicate(
      (widget) => findHeaderWithGrossAmountAndNetAmountProfit(
          widget, result.grossAmount, result.netAmountProfit),
    );
    expect(header, findsOneWidget);

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor aplicado inicialmente',
          result.investedAmount,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor bruto do investimento',
          result.grossAmount,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor do rendimento',
          result.grossAmountProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'IR sobre o investimento',
          result.incomeTax,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Valor líquido do investimento',
          result.netAmountProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Data de resgate',
          result.maturityDate,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Dias corridos',
          result.period,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Rendimento mensal',
          result.monthlyGrossRateProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Percentual do CDI do investimento',
          result.rate,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Rentabilidade anual',
          result.annualGrossRateProfit,
        ),
      ),
      findsOneWidget,
    );

    expect(
      find.byWidgetPredicate(
        (widget) => findRowWithTitleAndDescription(
          widget,
          'Rentabilidade no período',
          result.rateProfit,
        ),
      ),
      findsOneWidget,
    );

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(
        widget,
        'Simular novamente',
        isEnabled: true,
      ),
    );
    expect(button, findsOneWidget);
  });

  // quando o repositório responder erro, deve mostrar tela de erro.
  testWidgets('when request fails', (tester) async {
    when(repository.doSimulation(any)).thenThrow(Exception('error'));

    await tester.pumpWidget(setupContainer(
      ResultContainer(
        onBack: expectAsync1((_) {}, count: 0),
      ),
    ));
    await tester.pumpAndSettle();

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

  // quando o repositório responder erro, deve mostrar tela de erro.
  testWidgets('when request fails and click on try again returns success',
      (tester) async {
    when(repository.doSimulation(any)).thenThrow(Exception('error'));

    await tester.pumpWidget(setupContainer(
      ResultContainer(
        onBack: expectAsync1((_) {}, count: 0),
      ),
    ));
    await tester.pumpAndSettle();

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
  // na tela de sucesso, quando clicar no botão simular novamente deve triggar o voltar.
  testWidgets('when simulate again button is clicked', (tester) async {
    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    await tester.pumpWidget(setupContainer(
      ResultContainer(
        onBack: expectAsync1((_) {}, count: 1),
      ),
    ));
    await tester.pumpAndSettle();

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

  testWidgets('when try again button is clicked', (tester) async {
    when(repository.doSimulation(any)).thenAnswer((_) async => result);

    await tester.pumpWidget(setupContainer(
      ResultContainer(
        onBack: expectAsync1((_) {}, count: 1),
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
  });
}
