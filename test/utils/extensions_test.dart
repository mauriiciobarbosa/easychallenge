import 'package:easychallenge/utils/extensions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('#fromMoneyToDouble', () {
    expect('R\$ 31.000,00'.fromMoneyToDouble(), 31000);
    expect('R\$ 31.000,55'.fromMoneyToDouble(), 31000.55);
    expect('R\$ 999,99'.fromMoneyToDouble(), 999.99);
    expect('R\$ 0,00'.fromMoneyToDouble(), 0);
    expect('R\$ 55,559'.fromMoneyToDouble(), 55.559);
  });
  test('#removeMoneyFormat', () {
    expect('R\$ 31.000,00'.removeMoneyFormat(), '31000.00');
    expect('R\$ 31.000,55'.removeMoneyFormat(), '31000.55');
    expect('R\$ 999,99'.removeMoneyFormat(), '999.99');
    expect('R\$ 0,00'.removeMoneyFormat(), '0.00');
    expect('R\$ 55,559'.removeMoneyFormat(), '55.559');
  });
}
