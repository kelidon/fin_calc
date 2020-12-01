import 'package:fin_calc/bloc/calculation_bloc.dart';
import 'package:fin_calc/utils/calculator_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final operationToLabelMap = {
  Operations.ADD: "+",
  Operations.DISTRACT: "-",
  Operations.MULTIPLY: "*",
  Operations.DIVIDE: "/",
};

class ButtonWidget extends StatelessWidget{
  final int blocOperationIndex;
  final Operations operation;

  const ButtonWidget({Key key, this.blocOperationIndex, this.operation}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalculationBloc, CalculationState>(
      builder: (_, state) {
        bool isActive = state.operations[blocOperationIndex] == operation;
        return Container(
          decoration: BoxDecoration(
            color: isActive?Colors.black.withOpacity(0.7):Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: InkWell(
            onTap: () => context.bloc<CalculationBloc>().add(OperationChanged(blocOperationIndex, operation)),
            child: Container(
              width: MediaQuery.of(context).size.width/15,
              height: 40,
              child: Center(
                child: Text(operationToLabelMap[operation], style: TextStyle(fontSize: 20, color: isActive?Colors.white:Colors.black),),
              ),
            ),
          ),
        );
      }
    );
  }

}
