import 'package:fin_calc/bloc/calculation_bloc.dart';
import 'package:fin_calc/utils/calculator_util.dart';
import 'package:fin_calc/utils/string_formatter.dart';
import 'package:fin_calc/widgets/decimal_input_widget.dart';
import 'package:fin_calc/widgets/operations_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: 50, left: 50, right: 50),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DecimalInputWidget(blocDecimalIndex: 0,),
                    OperationsWidget(blocOperationIndex: 0,),

                    DecimalInputWidget(blocDecimalIndex: 1,),
                    OperationsWidget(blocOperationIndex: 1,),
                    DecimalInputWidget(blocDecimalIndex: 2,),

                    OperationsWidget(blocOperationIndex: 2,),
                    DecimalInputWidget(blocDecimalIndex: 3,),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<CalculationBloc, CalculationState>(
                      builder: (_, state){
                        var resultText = CalculatorUtil.calculateFinCalcResult(state.operations, state.decimals).toStringAsFixed(6);
                        var outputText = StringFormatter.beautifyOutput(resultText);
                        return Text(outputText, style:  TextStyle(height: 1.5),);
                      },
                    )
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(
                      top: 50, left: 50, right: 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    "Щорс Виктор Сергеевич\n4 курс\n4 группа\n2020", textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
