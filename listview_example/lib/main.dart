import 'package:flutter/material.dart';
import 'Sub/firstPage.dart';
import 'Sub/secondPage.dart';
import './animalItem.dart';
import './cupertinoMain.dart';

void main() {
  runApp(const CupertinoMain());
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController controller;
  List<Animal> animalList = [];

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }


  @override
  void initState(){
    super.initState();
    //vsync는 탭이 이동해 쓸때 호출되는 콜백 함수를 어디서 처리할지를 지정
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png", flyExist: false));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png", flyExist: false));
    animalList.add(Animal(animalName: "젖소", kind: "포유류", imagePath: "repo/images/cow.png", flyExist: false));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png", flyExist: false));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png", flyExist: false));
    animalList.add(Animal(animalName: "원숭이", kind: "포유류", imagePath: "repo/images/monkey.png", flyExist: false));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png", flyExist: false));
    animalList.add(Animal(animalName: "늑대", kind: "포유류", imagePath: "repo/images/wolf.png", flyExist: false));


  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      print('이전 Index, ${controller.previousIndex}');
      print('현대 Index, ${controller.index}');
    });

      return Scaffold(
        appBar: AppBar(
          title: Text('ListView Example'),
        ),
        body: TabBarView(
          children: [
            FirstApp(list: this.animalList,),
            SecondApp(list: this.animalList)]
          ,
          controller: controller,
        ),
        bottomNavigationBar: TabBar(tabs: [
          Tab(icon: Icon(Icons.looks_one, color: Colors.blue,),),
          Tab(icon: Icon(Icons.looks_two, color: Colors.blue,),),
        ], controller: controller,),
      );
  }
}
