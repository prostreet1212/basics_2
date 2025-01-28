import 'package:flutter/material.dart';
import 'dart:math' as Math;

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimationWidget(),
      ),
    );
  }
}

class AnimationWidget extends StatefulWidget {
  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;
  late Animation<double> moveDown;
  late Animation<double> scale;

  late Animation<BorderRadius?> borderRadius;
  late Animation<Color?> colorContainer;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));

    borderRadius = BorderRadiusTween(
            begin: BorderRadius.circular(4.0), end: BorderRadius.circular(75.0))
        .animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.375,
        0.500,
        curve: Curves.ease,
      ),
    ));
    colorContainer =
        ColorTween(begin: Colors.indigo[100], end: Colors.red).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.500,
          0.750,
          curve: Curves.ease,
        ),
      ),
    );

    controller.addListener(() {
      print('Status ${controller.status}');
      if (controller.status == AnimationStatus.completed) {
        controller.reset();
      } /*else if(rotation.value>2.0){
        controller.reset();
      }*/
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //controller.forward();
    controller.repeat();

    return AnimatedBuilder(
      animation: controller,
      child: _MyContainer(),
      builder: (context, childContainer) {
        //print(rotation.value);
        return Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: colorContainer.value,
            border: Border.all(
              color: Colors.indigo[300] as Color,
              width: 3,
            ),
            borderRadius: borderRadius.value,
          ),
        );
      },
    );
  }
}

class _MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(color: Colors.orange),
    );
  }
}
