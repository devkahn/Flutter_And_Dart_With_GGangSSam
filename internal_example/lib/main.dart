import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHome()

    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int _count =0;

  //데이터를 저장하는 함수
  void _setData(int value) async{
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(key, value);
  }

  //데이터를 가져오는 함수
  void _loadData() async{
    var key = 'count';
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      var value = pref.getInt(key);
      if(value == null){
        _count =0;
      } else{
        _count = value;
      }
    });
  }

  void _incrementCounter(){
    setState(() {
      _count++;
      _setData(_count);
    });
  }


  @override
  void initState(){
    super.initState();
    _loadData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You have pushed the button this many times'),
              Text('$_count', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            _incrementCounter();
          });
        },
      ) ,
    );
  }
}

