import 'package:easynvest_app/screens/cubit/investment_cubit_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InvestmentInitialState initialState;

  setUp(() {
    initialState = InvestmentInitialState(date: '', amount: '', rate: '');
  });

  test('when all fields are valid', () {
    final state = initialState.copyWith(
        date: '31/12/2040', rate: '50', amount: 'R\$ 100.000,00');

    expect(state.isAllFieldsValid(), isTrue);
  });

  test('when amount is zero', () {
    final state = initialState.copyWith(
        date: '31/12/2040', rate: '50', amount: 'R\$ 0,00');

    expect(state.isAllFieldsValid(), isFalse);
    expect(state.selectedAmount, 0.0);
  });

  test('when rate is zero', () {
    final state = initialState.copyWith(
        date: '31/12/2040', rate: '0', amount: 'R\$ 100.000,00');

    expect(state.isAllFieldsValid(), isFalse);
    expect(state.selectedRate, 0.0);
  });

  test('when date is empty', () {
    final state =
        initialState.copyWith(date: '', rate: '50', amount: 'R\$ 100.000,00');

    expect(state.isAllFieldsValid(), isFalse);
    expect(() => state.selectedDate, throwsA(isFormatException));
  });

  test('when date is before actual date', () {
    final state = initialState.copyWith(
        date: '31/12/2020', rate: '50', amount: 'R\$ 100.000,00');

    expect(state.isAllFieldsValid(), isFalse);
  });

  test('when amount is greater than zero', () {
    final state = initialState.copyWith(
        date: '31/12/2020', rate: '50', amount: 'R\$ 99.999,99');

    expect(state.selectedAmount, 99999.99);
  });

  test('when rate is greater than zero', () {
    final state = initialState.copyWith(
        date: '31/12/2020', rate: '100', amount: 'R\$ 100.000,00');

    expect(state.selectedRate, 100);
  });

  test('when date is valid and greater or equal than actual date', () {
    final state = initialState.copyWith(
        date: '31/12/2030', rate: '50', amount: 'R\$ 99.999,99');

    expect(state.selectedDate, '2030-12-31');
  });
}
