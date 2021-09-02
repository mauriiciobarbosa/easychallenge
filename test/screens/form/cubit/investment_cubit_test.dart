import 'package:bloc_test/bloc_test.dart';
import 'package:easychallenge/screens/form/cubit/investment_cubit.dart';
import 'package:easychallenge/screens/form/cubit/investment_cubit_state.dart';

void main() {
  blocTest<InvestmentCubit, InvestmentCubitState>(
    'when value is changed',
    build: () => InvestmentCubit(),
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
}
