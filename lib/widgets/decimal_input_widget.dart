import 'package:decimal/decimal.dart';
import 'package:fin_calc/bloc/calculation_bloc.dart';
import 'package:fin_calc/utils/calculator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DecimalInputWidget extends StatefulWidget {
  final int blocDecimalIndex;

  const DecimalInputWidget({Key key, this.blocDecimalIndex}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DecimalInputWidgetState();
}

class _DecimalInputWidgetState extends State<DecimalInputWidget> {
  final _controller = TextEditingController(text: "0");
  bool _isBadInput = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _controller,
        style: TextStyle(height: 1.5),
        decoration: InputDecoration(
          labelText: 'Input value',
          errorText: _isBadInput ? "Bad input" : null,
        ),
        onChanged: (value) {
          setState(() {
            _isBadInput = CalculatorUtil.isBadDecimal(value);
            context.bloc<CalculationBloc>().add(DecimalChanged(
                widget.blocDecimalIndex,
                _isBadInput
                    ? null
                    : Decimal.parse(_controller.text.replaceAll(',', '.').replaceAll(" ", ""))));
          });
        },
      ),
    );
  }
}
