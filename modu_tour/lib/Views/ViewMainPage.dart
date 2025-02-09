import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modu_tour/Defines/Defines.dart';
import 'ViewFavoritePage.dart';
import 'ViewSettingPage.dart';
import 'ViewMap.dart';






class ViewMainPage extends StatefulWidget {
  const ViewMainPage({Key? key}) : super(key: key);

  @override
  State<ViewMainPage> createState() => _ViewMainPageState();
}

class _ViewMainPageState extends State<ViewMainPage> with SingleTickerProviderStateMixin  {
  late TabController _controller;
  late FirebaseDatabase _database;
  DatabaseReference? _reference = null;
  String id ="";

  @override
  void initState(){
    super.initState();
    _controller = TabController(length: 3, vsync: this);
    _database = FirebaseDatabase(databaseURL: Defines.BASE_URL);
    _reference = _database.reference();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    id = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      body: TabBarView(
        children: [
          //ViewMap(),
          ViewFavoritePage(),
          ViewSettingPage(),
        ],
        controller: _controller,
      ),
      bottomNavigationBar: TabBar(
        tabs : <Tab>[
          Tab(icon:Icon(Icons.map)),
          Tab(icon:Icon(Icons.star)),
          Tab(icon:Icon(Icons.settings))
        ],
        labelColor: Colors.green,
        indicatorColor: Colors.deepOrangeAccent,
        controller: _controller,
      ),
    );
  }
}
