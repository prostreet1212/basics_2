import 'dart:math';

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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();

    tiles = [
      Padding(
        key:UniqueKey(),
        padding: const EdgeInsets.all(8.0),
        child: ColorWidget(text: '1',),
      ),
      Padding(
        key:UniqueKey(),
        padding: const EdgeInsets.all(8.0),
        child: ColorWidget(text: '2',),
      ),
    ];
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UniqueKey'),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tiles,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.swap_horiz, size: 32),
        onPressed: swapTiles,
      ),
    );
  }
}

class ColorWidget extends StatefulWidget {
  String text;

  ColorWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ColorWidget> createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  late final Color myColor;

  @override
  void initState() {
    super.initState();
    myColor = GenerateColor.getColor();
  }

  @override
  Widget build(BuildContext context) {
    print(
        '$myColor element: ${context.hashCode} render:${context.findRenderObject().hashCode}');
    return Container(
      height: 150,
      width: 150,
      color: myColor,
      child: Center(
        widthFactor: 100,
        child: Text(
          widget.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class GenerateColor {
  static final random = Random();

  static Color getColor() {
    return Color.fromARGB(
      255,
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
    );
  }
}
