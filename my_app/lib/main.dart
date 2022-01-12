import 'package:flutter/material.dart';
import 'navigation/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CustomNavigationBar(),
    );
  }
}
