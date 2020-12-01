import 'package:decimal/decimal.dart';
import 'package:fin_calc/utils/calculator_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'calculation_event.dart';

part 'calculation_state.dart';

class CalculationBloc extends Bloc<CalculationEvent, CalculationState> {
  CalculationBloc()
      : super(CalculationState(operations: [
          Operations.ADD,
          Operations.ADD,
          Operations.ADD
        ], decimals: [
          Decimal.zero,
          Decimal.zero,
          Decimal.zero,
          Decimal.zero
        ]));

  @override
  Stream<CalculationState> mapEventToState(CalculationEvent event) async* {
    if (event is OperationChanged) {
      var newOperations = state.operations;
      newOperations.removeAt(event.index);
      newOperations.insert(event.index, event.value);
      yield state.copyWith(operations: newOperations);
    } else if (event is DecimalChanged) {
      var newDecimals = state.decimals;
      newDecimals.removeAt(event.index);
      newDecimals.insert(event.index, event.value);
      yield state.copyWith(decimals: newDecimals);
    }
  }
}
