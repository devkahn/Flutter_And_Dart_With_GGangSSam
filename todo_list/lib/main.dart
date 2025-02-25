import 'package:flutter/material.dart';
import 'package:todo_list/thirdPage.dart';
import 'secondDetail.dart';
import 'subDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/' : (context) => SubDetail(),
        '/second' : (context) => SecondDetail(),
        '/third' : (context) => ThirdDetail()
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

