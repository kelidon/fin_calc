import 'package:decimal/decimal.dart';
import 'package:fin_calc/bloc/calculation_bloc.dart';
import 'package:fin_calc/bloc/round_bloc.dart';
import 'package:fin_calc/utils/calculator_util.dart';
import 'package:fin_calc/utils/string_formatter.dart';
import 'package:fin_calc/widgets/decimal_input_widget.dart';
import 'package:fin_calc/widgets/operations_widget.dart';
import 'package:fin_calc/widgets/output_widget.dart';
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
                margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                padding: EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    DecimalInputWidget(
                      blocDecimalIndex: 0,
                    ),
                    OperationsWidget(
                      blocOperationIndex: 0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red[200],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        children: [
                          DecimalInputWidget(
                            blocDecimalIndex: 1,
                          ),
                          OperationsWidget(
                            blocOperationIndex: 1,
                          ),
                          DecimalInputWidget(
                            blocDecimalIndex: 2,
                          ),
                        ],
                      ),
                    ),
                    OperationsWidget(
                      blocOperationIndex: 2,
                    ),
                    DecimalInputWidget(
                      blocDecimalIndex: 3,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: BlocBuilder<CalculationBloc, CalculationState>(
                            builder: (_, state) {
                          if (!state.decimals.contains(null)) {
                            try {
                              Decimal result = CalculatorUtil.calculateFinCalcResult(
                                  state.operations, state.decimals);
                              var resultText =
                              result
                                      .toString();
                              var outputText =
                                  StringFormatter.beautifyOutput(resultText);
                              return Column(
                                children: [
                                  Text("Result:",
                                      style: TextStyle(height: 1.5)),
                                  OutputWidget(text: outputText),
                                  SizedBox(height: 20,),
                                  Text("Choose result rounding method:",
                                      style: TextStyle(height: 1.5)),
                                  BlocBuilder<RoundBloc, Round>(
                                    builder: (_, roundState){
                                      String roundedResult = "";
                                      switch(roundState){
                                        case Round.MATH:
                                          roundedResult = result.round().toString();
                                          break;
                                        case Round.BANK:
                                          var ten = Decimal.fromInt(10);
                                          roundedResult = result.truncate()%ten%Decimal.fromInt(2)==Decimal.zero?result.truncate().toString():result.round().toString();
                                          break;
                                        case Round.TRNC:
                                          roundedResult = result.truncate().toString();
                                          break;
                                      }
                                      return Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () => context.bloc<RoundBloc>().add(Round.MATH),
                                                child: Container(
                                                  color: roundState == Round.MATH?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.7),
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                  child: Text("MATH", style: TextStyle(color: roundState == Round.MATH?Colors.white:Colors.black),),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => context.bloc<RoundBloc>().add(Round.BANK),
                                                child: Container(
                                                  color: roundState == Round.BANK?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.7),
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                  child: Text("BANK", style: TextStyle(color: roundState == Round.BANK?Colors.white:Colors.black),),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => context.bloc<RoundBloc>().add(Round.TRNC),
                                                child: Container(
                                                  color: roundState == Round.TRNC?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.7),
                                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                  child: Text("TRNC", style: TextStyle(color: roundState == Round.TRNC?Colors.white:Colors.black),),
                                                ),
                                              )
                                            ],
                                          ),
                                          OutputWidget(text: roundedResult),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              );
                            } on Exception catch (e) {
                              return OutputWidget(
                                text: e.toString(),
                              );
                            }
                          } else
                            return OutputWidget(text: "Can't calculate");
                        }))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 50, left: 50, right: 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    "Щорс Виктор Сергеевич\n4 курс\n4 группа\n2020",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
