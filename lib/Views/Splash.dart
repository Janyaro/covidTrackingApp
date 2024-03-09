import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin  {
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this )
    ..repeat();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          AnimatedBuilder(animation: _controller,
           builder:(BuildContext context , Widget ? child ){
             return Transform.rotate(
              angle: _controller.value *2.0 * math.pi,
              child: child,
            
              );
           },
          child:  Container(
            height: 200,
            width: 200,
            child: const Center(
              child: Image(
                      image: AssetImage('images/virus.png'),
                    ),
            ),
          ) )
        ]
        ),
    );
  }
}
