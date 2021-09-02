import 'package:easychallenge/utils/extensions.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

abstract class InvestmentCubitState extends Equatable {
  const InvestmentCubitState();
}

class InvestmentInitialState extends InvestmentCubitState {
  const InvestmentInitialState({
    required this.date,
    required this.amount,
    required this.rate,
  });

  final String date;
  final String amount;
  final String rate;

  double get selectedAmount {
    return amount.fromMoneyToDouble();
  }

  String get selectedDate {
    final dateFormatter = DateFormat('dd/MM/yyyy', 'pt_BR');
    final selectedDateFormatter = DateFormat('yyyy-MM-dd', 'pt_BR');
    return selectedDateFormatter.format(dateFormatter.parse(date));
  }

  double get selectedRate => double.parse(rate);

  InvestmentInitialState copyWith({
    String? date,
    String? amount,
    String? rate,
  }) {
    return InvestmentInitialState(
      date: date ?? this.date,
      amount: amount ?? this.amount,
      rate: rate ?? this.rate,
    );
  }

  bool isAllFieldsValid() {
    initializeDateFormatting('pt_BR');
    final dateFormatter = DateFormat('dd/MM/yyyy', 'pt_BR');

    final currentAmount = double.tryParse(amount.removeMoneyFormat());
    final currentRate = double.tryParse(rate);
    bool isValidDate = false;

    try {
      final currentDate = dateFormatter.parse(date);
      isValidDate = currentDate.isAfter(DateTime.now());
    } catch (FormatException) {
      isValidDate = false;
    }

    return currentAmount != null &&
        currentAmount > 0 &&
        currentRate != null &&
        currentRate > 0 &&
        isValidDate;
  }

  @override
  List<Object?> get props => [date, amount, rate];
}
