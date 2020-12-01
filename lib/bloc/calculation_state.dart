part of 'calculation_bloc.dart';

class CalculationState {
  final List<Operations> operations;
  final List<Decimal> decimals;

  const CalculationState({this.operations, this.decimals});

  CalculationState copyWith(
      {List<Operations> operations, List<Decimal> decimals}) {
    return CalculationState(
        operations: operations ?? this.operations,
        decimals: decimals ?? this.decimals);
  }
}
