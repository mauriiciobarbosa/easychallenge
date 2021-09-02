import 'package:easychallenge/screens/form/cubit/investment_cubit.dart';
import 'package:easychallenge/screens/form/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../matchers.dart';

void main() {
  late InvestmentCubit cubit;

  setUp(() {
    cubit = InvestmentCubit();
  });

  MaterialApp setupContainer(Widget widget) {
    return MaterialApp(
      home: BlocProvider<InvestmentCubit>(
        create: (context) => cubit,
        child: widget,
      ),
    );
  }

  testWidgets('initial state', (tester) async {
    await tester.pumpWidget(setupContainer(FormScreen(
      onPressed: expectAsync1((_) {}, count: 0),
    )));

    expect(find.widgetWithText(AppBar, 'Formulário'), findsOneWidget);

    final moneyField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'R\$ 0,00',
        'Quanto você gostaria de aplicar? *',
      ),
    );
    expect(moneyField, findsOneWidget);

    final dateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'dia/mês/ano',
        'Qual a data de vencimento do investimentos? *',
      ),
    );
    expect(dateField, findsOneWidget);

    final rateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        '100%',
        'Qual o percentual do CDI do investimento? *',
      ),
    );
    expect(rateField, findsOneWidget);

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(widget, 'Simular', isEnabled: false),
    );

    expect(button, findsOneWidget);
  });

  testWidgets('when all fields are valid', (tester) async {
    await tester.pumpWidget(setupContainer(FormScreen(
      onPressed: expectAsync1((_) {}, count: 0),
    )));

    final moneyField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'R\$ 0,00',
        'Quanto você gostaria de aplicar? *',
      ),
    );
    // como adicionar mais valor
    await tester.enterText(moneyField, '1000');

    final dateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'dia/mês/ano',
        'Qual a data de vencimento do investimentos? *',
      ),
    );
    await tester.enterText(dateField, '31/12/2040');

    final rateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        '100%',
        'Qual o percentual do CDI do investimento? *',
      ),
    );
    await tester.enterText(rateField, '100');
    // por qual motivo tive que utilizar?
    await tester.pumpAndSettle();

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(widget, 'Simular', isEnabled: true),
    );

    expect(button, findsOneWidget);
  });

  testWidgets('when some field is invalid after all fields are valid',
      (tester) async {
    await tester.pumpWidget(setupContainer(FormScreen(
      onPressed: expectAsync1((_) {}, count: 0),
    )));

    final moneyField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'R\$ 0,00',
        'Quanto você gostaria de aplicar? *',
      ),
    );
    await tester.enterText(moneyField, '1');

    final dateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'dia/mês/ano',
        'Qual a data de vencimento do investimentos? *',
      ),
    );
    await tester.enterText(dateField, '31/12/2020');

    final rateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        '100%',
        'Qual o percentual do CDI do investimento? *',
      ),
    );
    await tester.enterText(rateField, '100');
    await tester.pumpAndSettle();

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(widget, 'Simular', isEnabled: false),
    );

    expect(button, findsOneWidget);
  });

  testWidgets('when simulate button is clicked', (tester) async {
    await tester.pumpWidget(setupContainer(FormScreen(
      onPressed: expectAsync1((_) {}, count: 1),
    )));

    final moneyField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'R\$ 0,00',
        'Quanto você gostaria de aplicar? *',
      ),
    );
    // como adicionar mais valor
    await tester.enterText(moneyField, '1');

    final dateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        'dia/mês/ano',
        'Qual a data de vencimento do investimentos? *',
      ),
    );
    await tester.enterText(dateField, '31/12/2040');

    final rateField = find.byWidgetPredicate(
      (widget) => findFieldWithHintAndLabel(
        widget,
        '100%',
        'Qual o percentual do CDI do investimento? *',
      ),
    );
    await tester.enterText(rateField, '100');
    // por qual motivo tive que utilizar?
    await tester.pumpAndSettle();

    final button = find.byWidgetPredicate(
      (widget) => findButtonWithText(widget, 'Simular'),
    );

    await tester.tap(button);
  });
}
