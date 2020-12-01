import 'package:flutter_bloc/flutter_bloc.dart';

enum Round { MATH, BANK, TRNC }

class RoundBloc extends Bloc<Round, Round> {
  RoundBloc() : super(Round.MATH);

  @override
  Stream<Round> mapEventToState(Round event) async* {
    yield event;
  }
}
