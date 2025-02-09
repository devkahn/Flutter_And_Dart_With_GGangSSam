import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:modu_tour/Models/mTour.dart';
import 'package:modu_tour/Models/mListData.dart';
import 'package:modu_tour/Views/ViewTourDetialPage.dart';
import 'package:sqflite/sqflite.dart';

import '../Defines/Defines.dart';
import 'package:modu_tour/Views/wndTour';


class ViewMap extends StatefulWidget {
  final DatabaseReference databaseReference;
  final Future<Database> db;
  final String id;

   ViewMap({required this.databaseReference, required this.db, required this.id});
   @override
   State<ViewMap> createState() => _ViewMapState();
 }

 class _ViewMapState extends State<ViewMap> {
  List<DropdownMenuItem> list = [];
  List<DropdownMenuItem> subList =[];
  List<mTourData> tourData = [];
  late ScrollController _scrollController;

  late mItem area;
  late mItem kind;
  int page =1;

  @override
  void initState(){
    super.initState();
    list = mArea().SeoulArea;
    subList = mKind().Kinds;

    area = list[0].value;
    kind = subList[0].value;

    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange){
        page++;
        getAreaList(area: area.Value, contentTypeId: kind.Value, page: page);
      }
    });
  }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('검색하기'),
       ),
       body: Container(
         child: Center(
           child: Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   DropdownButton(
                       items: list,
                       onChanged: (value){
                         mItem selectedItem = value;
                         setState(() {
                           area = selectedItem;
                         });
                       },
                     value: area,
                   ),
                   SizedBox( width: 10,),
                   DropdownButton(
                       items: subList,
                       onChanged: (value){
                         mItem selectedItem = value;
                         setState(() {
                           kind =selectedItem;
                         });
                       },
                     value: kind,
                   ),
                   SizedBox( width: 10,),
                   ElevatedButton(
                       child: Text('검색하기', style: TextStyle(color: Colors.white, backgroundColor: Colors.blueAccent),),
                       onPressed: (){
                         page =1;
                         tourData.clear();
                         getAreaList(area: area.Value, contentTypeId: kind.Value, page: page);
                       },
                   ),
                   Expanded(
                       child: ListView.builder(
                           itemBuilder: (context, index){
                             return Card(
                               child: InkWell(
                                 child: Row(
                                   children: [
                                     Hero(
                                         tag: 'tourinfo$index',
                                         child: Container(
                                           margin: EdgeInsets.all(10),
                                           width: 100.0,
                                           height: 100.0,
                                           decoration: BoxDecoration(
                                             shape: BoxShape.circle,
                                             border: Border.all(color: Colors.black, width: 1),
                                             image: DecorationImage(
                                               fit: BoxFit.fill,
                                                 image: AssetImage('repo/images/map_location.png')
                                               //image: tourData[index].ImagePath != null ? NetworkImage(tourData[index].ImagePath) : AssetImage('repo/images/map_location.png')
                                             )
                                           ),
                                         )
                                     ),
                                     SizedBox(width: 20,),
                                     Container(
                                       child: Column(
                                         children: [
                                           Text(tourData[index].Title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                           Text('주소 : ${tourData[index].Address}'),
                                           tourData[index].Tel != null ? Text('전화번호 : ${tourData[index].Tel}') :Container(),
                                         ],
                                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       ),
                                       width: MediaQuery.of(context).size.width-150,
                                     )
                                   ],
                                 ),
                                 onTap: (){
                                   Navigator.of(context).push(MaterialPageRoute(
                                       builder: (context) => ViewTourDetailPage(
                                         id:widhet.id,
                                         tourData:tourData[index],
                                         index:index,
                                         DatabaseReference: widget.databaseReference
                                       )
                                   ));
                                 },
                               ),
                             );
                           },
                         itemCount: tourData.length,
                         controller: _scrollController,
                       )
                   )
                 ],
               )
             ],
             mainAxisAlignment: MainAxisAlignment.start,
           ),
         ),
       ),
     );
   }



   void getAreaList({required int area, required int contentTypeId, required int page}) async{
    var url ="";
    if(contentTypeId != 0){
      url += '&contentTypeId=$contentTypeId';
    }

   }
 }
