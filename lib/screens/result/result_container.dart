import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/screens/result/result_arguments.dart';
import 'package:easynvest_app/screens/result/result_error_screen.dart';
import 'package:easynvest_app/screens/result/result_loading_screen.dart';
import 'package:easynvest_app/screens/result/result_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/result_investment_cubit.dart';
import 'cubit/result_investment_state.dart';

class ResultContainer extends StatelessWidget {
  static const routeName = '/result';

  final VoidCallback onBack;
  final InvestmentSimulationRepository repository;

  ResultContainer({required this.onBack, required this.repository});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ResultArguments;

    return BlocProvider<ResultInvestmentCubit>(
      create: (BuildContext context) {
        return ResultInvestmentCubit(
          repository: repository,
        )..doSimulation(args.amount, args.rate, args.date);
      },
      child: ResultBlocContainer(args: args, onBack: onBack),
    );
  }
}

class ResultBlocContainer extends StatelessWidget {
  ResultBlocContainer({
    required this.args,
    required this.onBack,
  });

  final VoidCallback onBack;
  final ResultArguments args;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultInvestmentCubit, ResultInvestmentCubitState>(
      builder: (context, state) {
        if (state is ResultInvestmentLoadedState) {
          return ResultSuccessScreen(result: state.result, onBack: onBack);
        } else if (state is ResultInvestmentErrorState) {
          return ResultErrorScreen(
            error: state.error,
            onBack: onBack,
            onPressed: () {
              context
                  .read<ResultInvestmentCubit>()
                  .doSimulation(args.amount, args.rate, args.date);
            },
          );
        } else {
          return ResultLoadingScreen(onBack: onBack);
        }
      },
    );
  }
}
