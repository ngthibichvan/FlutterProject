import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/counter/counter_event.dart';
import 'package:my_app/bloc/counter/counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(counter: 0)) {
    on<IncrementEvent>(_increment);
    on<DecrementEvent>(_decrement);
  }

  void _increment(IncrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(counter: state.counter + 1));
  }

  void _decrement(DecrementEvent event, Emitter<CounterState> emit) {
    emit(CounterState(counter: state.counter - 1));
  }
}
