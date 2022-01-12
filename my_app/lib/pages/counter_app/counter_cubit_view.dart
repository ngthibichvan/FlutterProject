import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/bloc/counter/counter_cubit.dart';

class CounterViewUseCubit extends StatefulWidget {
  const CounterViewUseCubit({Key? key}) : super(key: key);

  @override
  _CounterViewUseCubitState createState() => _CounterViewUseCubitState();
}

class _CounterViewUseCubitState extends State<CounterViewUseCubit> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const CounterPage(),
    );
  }
}

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, count) => Center(child: Text('$count')),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => context.read<CounterCubit>().increment()),
          const SizedBox(height: 4),
          FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<CounterCubit>().decrement())
        ],
      ),
    );
  }
}
