import 'package:fileio_example/introPage.dart';
import 'package:flutter/material.dart';
import 'fileApp.dart';
import 'largeFileMain.dart';
import 'introPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('로고바꾸기'),
        actions: [
          TextButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => largeFileMain()));
              },
              child: Text('로고바꾸기', style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      
      body: Container(),

    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

