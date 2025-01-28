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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    rotation = Tween<double>(begin: 0.0, end: 2 * Math.pi)
        //.animate(controller);
        .animate(CurvedAnimation(parent: controller, curve: Curves.bounceOut));
    
    opacity=Tween(begin: 0.1,end: 1.0).animate(controller);
    moveDown=Tween(begin: 0.0,end: 200.0).animate(controller);
    scale=Tween(begin: 0.0,end: 1.0).animate(controller);

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
        return Transform.translate(
          offset: Offset(0, moveDown.value),
          child: Transform.rotate(
              angle: rotation.value,
              child: Opacity(
                opacity: opacity.value,
                  child: Transform.scale(
                    scale: scale.value,
                      child: childContainer))),
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
