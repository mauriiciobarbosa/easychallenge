import 'package:easynvest_app/data/investment_simulation_repository.dart';
import 'package:easynvest_app/screens/form/form_screen.dart';
import 'package:easynvest_app/screens/result/result_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      home: FormContainer(),
      routes: {
        ResultContainer.routeName: (context) => ResultContainer(
              repository: new InvestmentSimulationRepository(),
              onBack: () => Navigator.pop(context),
            )
      },
    );
  }
}
