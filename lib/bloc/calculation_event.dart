part of 'calculation_bloc.dart';

abstract class CalculationEvent{}

class DecimalChanged extends CalculationEvent {
  final int index;
  final Decimal value;

  DecimalChanged(this.index, this.value);
}

class OperationChanged extends CalculationEvent {
  final int index;
  final Operations value;

  OperationChanged(this.index, this.value);
}
