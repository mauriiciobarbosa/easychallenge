import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easynvest_app/components/button.dart';
import 'package:easynvest_app/components/input_field.dart';
import 'package:easynvest_app/screens/form/cubit/investment_cubit.dart';
import 'package:easynvest_app/screens/form/cubit/investment_cubit_state.dart';
import 'package:easynvest_app/screens/result/result_arguments.dart';
import 'package:easynvest_app/screens/result/result_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvestmentCubit>(
      create: (BuildContext context) => InvestmentCubit(),
      child: FormScreen(
        onPressed: (context) {
          final state = BlocProvider.of<InvestmentCubit>(context).state
              as InvestmentInitialState;
          Navigator.pushNamed(
            context,
            ResultContainer.routeName,
            arguments: ResultArguments(state.amount, state.rate, state.date),
          );
        },
      ),
    );
  }
}

class FormScreen extends StatelessWidget {
  FormScreen({required this.onPressed});

  final void Function(BuildContext context) onPressed;

  final TextEditingController amountInputFieldController =
      TextEditingController();
  final TextEditingController dateInputFieldController =
      TextEditingController();
  final TextEditingController rateInputFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvestmentCubit, InvestmentCubitState>(
      builder: (context, state) {
        _fillFieldsIfNeeded(state as InvestmentInitialState);
        return Scaffold(
          appBar: AppBar(
            title: Text('Formulário'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // how to make this input field's aligned proportionally to center.
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InputField(
                    keyboardType: TextInputType.number,
                    label: 'Quanto você gostaria de aplicar? *',
                    hint: 'R\$ 0,00',
                    inputFormatter: CurrencyTextInputFormatter(
                      locale: 'pt_Br',
                      symbol: 'R\$',
                    ),
                    inputFieldController: amountInputFieldController,
                    onChanged: (_) {
                      _onValueChanged(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InputField(
                    keyboardType: TextInputType.number,
                    label: 'Qual a data de vencimento do investimentos? *',
                    hint: 'dia/mês/ano',
                    // inputFormatter: MaskTextInputFormatter(mask: "##/##/####"),
                    inputFormatter: null,
                    inputFieldController: dateInputFieldController,
                    onChanged: (_) {
                      _onValueChanged(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InputField(
                    keyboardType: TextInputType.number,
                    label: 'Qual o percentual do CDI do investimento? *',
                    hint: '100%',
                    // inputFormatter: MaskTextInputFormatter(mask: "###"),
                    inputFormatter: null,
                    inputFieldController: rateInputFieldController,
                    onChanged: (_) {
                      _onValueChanged(context);
                    },
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Button(
                text: 'Simular',
                onPressed: _isSimulationEnabled(state)
                    ? () {
                        onPressed(context);
                      }
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }

  _onValueChanged(BuildContext context) {
    // print('calling');
    final cubit = context.read<InvestmentCubit>();

    cubit.onValueChanged(
      amountInputFieldController.text,
      rateInputFieldController.text,
      dateInputFieldController.text,
    );
  }

  bool _isSimulationEnabled(InvestmentCubitState state) {
    return state is InvestmentInitialState && state.isAllFieldsValid();
  }

  void _fillFieldsIfNeeded(InvestmentInitialState state) {
    if (state.amount.isNotEmpty && state.amount != '0') {
      amountInputFieldController.value =
          amountInputFieldController.value.copyWith(text: state.amount);
    }

    if (state.rate.isNotEmpty && state.rate != '0') {
      rateInputFieldController.value =
          rateInputFieldController.value.copyWith(text: state.rate);
    }

    if (state.date.isNotEmpty && state.date != '0') {
      dateInputFieldController.value =
          dateInputFieldController.value.copyWith(text: state.date);
    }
  }
}
