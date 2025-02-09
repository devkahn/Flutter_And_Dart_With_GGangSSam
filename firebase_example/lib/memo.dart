import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class Memo{
   late String key;
   late String title;
   late String content;
   late String createTime;

   Memo(this.title, this.content, this.createTime);

   Memo.fromSnapshot(DataSnapshot snapshot){
     print('snapshot : ${snapshot.value}');
     Map<Object?, Object?> map = snapshot.value as Map<Object?, Object?>;
     key = snapshot.key!;
     title = map['title'].toString();
     content = map['content'].toString();
     createTime = map['createTime'].toString();
   }

   toJson(){
     return {
       'title' : title,
       'content' : content,
       'createTime' : createTime
     };
   }
}