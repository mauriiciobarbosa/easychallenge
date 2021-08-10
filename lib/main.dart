import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/screens/cubit/investment_cubit.dart';
import 'package:easynvest_app/screens/form/form_screen.dart';
import 'package:easynvest_app/screens/result/result_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
        accentColor: Colors.greenAccent,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
        ),
      ),
      home: BlocProvider(
        create: (BuildContext context) => InvestmentCubit(
          repository: new InvestmentSimulationRepository(),
        ),
        child: FormScreen(
          onPressed: (childContext) {
            Navigator.push(
              childContext,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<InvestmentCubit>(childContext),
                  child: ResultContainer(
                    onBack: () {
                      Navigator.pop(childContext);
                      childContext.read<InvestmentCubit>().goBack();
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
