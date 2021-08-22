import 'package:easynvest_app/domain/investment_simulation_result.dart';
import 'package:equatable/equatable.dart';

abstract class ResultInvestmentCubitState extends Equatable {
  const ResultInvestmentCubitState();
}

class ResultInvestmentLoadingState extends ResultInvestmentCubitState {
  const ResultInvestmentLoadingState();

  @override
  List<Object?> get props => [];
}

class ResultInvestmentLoadedState extends ResultInvestmentCubitState {
  const ResultInvestmentLoadedState(this.result);

  final InvestmentSimulationResult result;

  @override
  List<Object?> get props => [result];
}

class ResultInvestmentErrorState extends ResultInvestmentCubitState {
  const ResultInvestmentErrorState(this.error);

  final String error;

  @override
  List<Object?> get props => [error];
}