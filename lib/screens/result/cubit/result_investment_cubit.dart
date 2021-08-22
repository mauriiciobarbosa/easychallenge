import 'package:easynvest_app/data/dtos/investment_simulation_request.dart';
import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:easynvest_app/screens/result/cubit/result_investment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultInvestmentCubit extends Cubit<ResultInvestmentCubitState> {
  ResultInvestmentCubit({required InvestmentSimulationRepository repository})
      : _repository = repository,
        super(ResultInvestmentLoadingState());

  final InvestmentSimulationRepository _repository;

  Future<void> doSimulation(String amount, String rate, String date) async {
    emit(ResultInvestmentLoadingState());

    InvestmentSimulationRequest request = InvestmentSimulationRequest(
      investedAmount: amount,
      rate: rate,
      maturityDate: date,
    );

    try {
      InvestmentSimulationResult result =
          await _repository.doSimulation(request);

      emit(ResultInvestmentLoadedState(result));
    } catch (error) {
      emit(ResultInvestmentErrorState(error.toString()));
    }
  }
}
