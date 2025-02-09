import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  const ThirdDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Container(
        child: Center(
          child: Text(
            args.toString(),
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
