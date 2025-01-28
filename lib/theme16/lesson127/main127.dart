import 'package:basics_2/theme16/lesson127/value_key_example_1.dart';
import 'package:basics_2/theme16/lesson127/value_key_example_2.dart';
import 'package:basics_2/theme16/lesson127/value_key_example_3.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const ValueKeyExample3(),
    );
  }
}