extension StringParse on String {
  double fromMoneyToDouble() {
    final value = this.removeMoneyFormat();
    return double.parse(value);
  }

  String removeMoneyFormat() {
    return this
        .replaceAll('R\$', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim();
  }
}
