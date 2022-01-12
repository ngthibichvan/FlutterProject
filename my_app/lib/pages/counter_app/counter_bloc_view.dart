import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/counter/counter_bloc.dart';
import 'package:my_app/bloc/counter/counter_event.dart';
import 'package:my_app/bloc/counter/counter_state.dart';

class CounterViewUseBloc extends StatefulWidget {
  const CounterViewUseBloc({Key? key}) : super(key: key);

  @override
  _CounterViewUseBlocState createState() => _CounterViewUseBlocState();
}

class _CounterViewUseBlocState extends State<CounterViewUseBloc> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (context, state) => Center(child: Text('${state.counter}')),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  context.read<CounterBloc>().add(IncrementEvent())),
          const SizedBox(height: 4),
          FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () =>
                  context.read<CounterBloc>().add(DecrementEvent())),
        ],
      ),
    );
  }
}
