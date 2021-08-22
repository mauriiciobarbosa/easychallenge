import 'package:easynvest_app/screens/form/cubit/investment_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvestmentCubit extends Cubit<InvestmentCubitState> {
  InvestmentCubit()
      : super(InvestmentInitialState(amount: '0', rate: '0', date: '0'));

  InvestmentInitialState _lastSimulation =
      InvestmentInitialState(amount: '0', rate: '0', date: '0');

  Future<void> onValueChanged(String amount, String rate, String date) async {
    final currentState = state;
    if (currentState is InvestmentInitialState) {
      _lastSimulation =
          currentState.copyWith(amount: amount, date: date, rate: rate);
      emit(_lastSimulation);
    } else {
      assert(false, 'unexpected state $state');
    }
  }
}
