import 'package:flutter/material.dart';

class mItem{
  late String Title;
  late int Value;

  mItem(this.Title, this.Value);
}

class mArea{
  List<DropdownMenuItem> SeoulArea =[];

  mArea(){
    SeoulArea.add(DropdownMenuItem(child: Text('강남구'), value: mItem('강남구',1),));
  }
}


class mKind{
  List<DropdownMenuItem> Kinds = [];
  mKind(){
    Kinds.add(DropdownMenuItem(child: Text('관광지'), value: mItem('관광지',12),));
  }
}