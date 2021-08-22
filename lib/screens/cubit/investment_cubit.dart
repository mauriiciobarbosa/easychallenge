import 'package:easynvest_app/data/dtos/investment_simulation_request.dart';
import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:easynvest_app/screens/cubit/investment_cubit_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvestmentCubit extends Cubit<InvestmentCubitState> {
  InvestmentCubit({required InvestmentSimulationRepository repository})
      : _repository = repository,
        super(InvestmentInitialState(amount: '0', rate: '0', date: '0'));

  final InvestmentSimulationRepository _repository;

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

  Future<void> doSimulation() async {
    emit(InvestmentLoadingState());

    InvestmentSimulationRequest request = InvestmentSimulationRequest(
      investedAmount: _lastSimulation.selectedAmount.toString(),
      rate: _lastSimulation.selectedRate.toString(),
      maturityDate: _lastSimulation.selectedDate,
    );

    try {
      InvestmentSimulationResult result =
          await _repository.doSimulation(request);

      emit(InvestmentLoadedState(result));
    } catch (error) {
      emit(InvestmentErrorState(error.toString()));
    }
  }

  Future<void> goBack() async {
    await Future.delayed(Duration(milliseconds: 200));
    emit(_lastSimulation);
  }
}
