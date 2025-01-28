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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    rotation = Tween<double>(begin: 0.0, end: 2*Math.pi)
        //.animate(controller);
    .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));

    controller.addListener((){
      print('Status ${controller.status}');
      if(controller.status==AnimationStatus.completed){
        controller.reverse();
      }else if(controller.status==AnimationStatus.dismissed){
        controller.forward();
      }
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
    //controller.repeat();

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        //print(rotation.value);
        return Transform.rotate(
          angle: rotation.value,
            child: _MyContainer());
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
