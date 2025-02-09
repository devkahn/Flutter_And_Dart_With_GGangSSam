import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    print('createdState');
    return _MyApp();
  }

}

class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = 'Hello';
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    print('build');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.light(),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                value: switchValue,
                onChanged: (value){
                  setState(() {

                    print(value);
                    switchValue = value;
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _color


                ) ,
                child: Text('$test'),
                onPressed: (){
                  if (test == 'hello'){
                    setState(() {
                      test = 'flutter';
                      _color = Colors.red;
                    });
                  }
                  else{
                    setState(() {
                      test = 'hello';
                      _color  = Colors.purple;
                    });
                  }


                },
              )
            ],
          ),
        )
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    print('initState');
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    print('didChangeDependencies');
  }
}

