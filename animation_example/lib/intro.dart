import 'package:flutter/material.dart';
import 'package:animation_example/saturnLoading.dart';
import 'dart:async';
import 'main.dart';


class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  void initState(){
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('애니메이션 앱'),
              SizedBox(height: 20,),
              SaturnLoading()
            ],
          ),
        ),
      ),
    );
  }

  Future<Timer> loadData() async{
    return Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AnimationApp()));
  }
}
