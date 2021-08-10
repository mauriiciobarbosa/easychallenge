import 'package:easynvest_app/screens/result/result_error_screen.dart';
import 'package:easynvest_app/screens/result/result_loading_screen.dart';
import 'package:easynvest_app/screens/result/result_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/investment_cubit.dart';
import '../cubit/investment_cubit_state.dart';

class ResultContainer extends StatelessWidget {
  ResultContainer({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    // 1 - vai buildar novamente a tela na primeira vez que entrar.
    // 2 - o build pode ser chamado a qualquer momento.
    context.read<InvestmentCubit>().doSimulation();

    return BlocBuilder<InvestmentCubit, InvestmentCubitState>(
      builder: (context, state) {
        if (state is InvestmentLoadedState) {
          return ResultSuccessScreen(
            result: state.result,
            onBack: onBack,
          );
        } else if (state is InvestmentErrorState) {
          return ResultErrorScreen(
            error: state.error,
            onBack: onBack,
            onPressed: () {
              context.read<InvestmentCubit>().doSimulation();
            },
          );
        } else {
          return ResultLoadingScreen(
            onBack: onBack,
          );
        }
      },
    );
  }
}
