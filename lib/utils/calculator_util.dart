import 'dart:math';

import 'package:decimal/decimal.dart';

enum Operations { ADD, DISTRACT, MULTIPLY, DIVIDE }

final int precision = 10;

class CalculatorUtil {
  static bool isBadDecimal(String value) {
    if (value == null || value == "") return true;
    value = value.replaceAll(',', '.').replaceAll('e', 'no');
    if (Decimal.tryParse(value) != null) return false;
    if (Decimal.tryParse(value.replaceAll(" ", "")) == null)
      return true;
    else {
      RegExp inputRegExp = RegExp(r'((\d{0,3})(\ \d{3})*)((\.|,)\d+)?');
      var str = inputRegExp.stringMatch(value);
      return inputRegExp.stringMatch(value) != value;
    }
  }

  static roundWithPrecision(Decimal d, int precision) {
    var decimalPrecision = Decimal.fromInt(pow(10, precision));
    return (d * decimalPrecision).round() / decimalPrecision;
  }

  static Decimal calculate(
      Operations operation, Decimal first, Decimal second) {
    Decimal result;
    switch (operation) {
      case Operations.ADD:
        result = first + second;
        break;
      case Operations.DISTRACT:
        result = first - second;
        break;
      case Operations.MULTIPLY:
        result = first * second;
        break;
      case Operations.DIVIDE:
        if (second == Decimal.zero) throw Exception("Zero division");
        result = first / second;
        break;
    }
    return roundWithPrecision(result, precision);
  }

  //calculates [a # ( b @ c) & d] expression only
  //uses polish inversion
  //very simplified and hardcoded
  static calculateFinCalcResult(
      List<Operations> operations, List<Decimal> decimals) {
    //hardcode starts
    var secondOperationIndex = (operations[2] == Operations.DIVIDE ||
                operations[2] == Operations.MULTIPLY) &&
            (operations[0] == Operations.ADD ||
                operations[0] == Operations.DISTRACT)
        ? 2
        : 0;
    var thirdOperationIndex = 2 - secondOperationIndex;
    var preLastOperandIndex = secondOperationIndex == 0 ? 0 : 3;
    var lastOperandIndex = preLastOperandIndex == 0 ? 3 : 0;

    var operationsPolish = [
      operations[1],
      operations[secondOperationIndex],
      operations[thirdOperationIndex]
    ].reversed.toList();
    var decimalsPolish = [
      decimals[1],
      decimals[2],
      decimals[preLastOperandIndex],
      decimals[lastOperandIndex]
    ];
    //hardcode ends here

    while (operationsPolish.isNotEmpty) {
      decimalsPolish[1] = calculate(
          operationsPolish.last, decimalsPolish[0], decimalsPolish[1]);
      operationsPolish.removeLast();
      decimalsPolish.removeAt(0);
    }
    return roundWithPrecision(decimalsPolish[0], 6);
  }
}
