import 'package:flutter/material.dart';
import 'package:material_flutter_app/imageWidget.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Flutter App',
      theme:ThemeData(
        primarySwatch: Colors.blue
      ),
      home: ImageWidgetApp(),
    );
  }
}


class MaterialFlutterApp extends StatefulWidget {
  const MaterialFlutterApp({Key? key}) : super(key: key);

  @override
  State<MaterialFlutterApp> createState() => _MaterialFlutterAppState();
}

class _MaterialFlutterAppState extends State<MaterialFlutterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Text('Material Design App'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){},
      ),
      body:  Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.android),
              Text('android'),
            ],
          ),
        ),
      ),
    );
  }
}



