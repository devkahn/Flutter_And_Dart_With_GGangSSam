import 'package:flutter/material.dart';
import 'dart:math';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _rotateAnimation;
  late Animation _scaleAnimation;
  late Animation _transAnimation;
  
  @override
  void initState(){
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 5), vsync: this);
    _rotateAnimation = Tween<double>(begin: 0, end: pi*10).animate(_animationController);
    _scaleAnimation = Tween<double>(begin: 1, end: 0).animate(_animationController);
    _transAnimation = Tween<Offset>(begin: Offset(0,0), end: Offset(200,200)).animate((_animationController));
  }
  
  @override
  void dispose(){
    _animationController.dispose();
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  Text('Animation Example2'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment:  MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _rotateAnimation, 
                  builder: (context, widget){
                    return Transform.translate(
                      offset: _transAnimation.value,
                      child: Transform.rotate(
                        angle: _rotateAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: widget,
                        )
                      ),
                    );
                  },
                child: Hero(tag: 'detail', child: Icon(Icons.cake, size: 300)),
              ),
              ElevatedButton(
                  onPressed: (){
                    _animationController.forward();
                  }, 
                  child: Text('로테이션 시작하기')
              )
            ],
          ),
        ),
      ),
    );
  }
}
