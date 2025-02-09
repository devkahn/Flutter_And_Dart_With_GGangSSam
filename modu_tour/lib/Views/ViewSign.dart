import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modu_tour/Helpers/MessageDialogHelper.dart';
import 'package:modu_tour/Models/mUser.dart';

import 'package:modu_tour/Defines/Defines.dart';





class ViewSign extends StatefulWidget {
  const ViewSign({Key? key}) : super(key: key);

  @override
  State<ViewSign> createState() => _ViewSignState();
}

class _ViewSignState extends State<ViewSign> {
  late FirebaseDatabase _database;
  late DatabaseReference _reference;

  late TextEditingController _idTextController;
  late TextEditingController _pwTextController;
  late TextEditingController _pwCheckController;


  @override
  void initState(){
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckController = TextEditingController();

    _database = FirebaseDatabase(databaseURL: Defines.BASE_URL);
    _reference = _database.reference().child(Defines.TABLE_NAME_USER);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('회원가입'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _idTextController,
                  maxLines: 1,
                  decoration: InputDecoration(hintText: '4자 이상 입력해주세요.', labelText: 'ID', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwTextController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(hintText: '6자 이상 입력해주세요.', labelText: 'PW', border: OutlineInputBorder()),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _pwCheckController,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(labelText: '비밀번호 확인', border: OutlineInputBorder()),
                ),
              ),
              SizedBox( height: 20,),
              TextButton(
                child: Text('회원가입', style: TextStyle(color: Colors.white, backgroundColor: Colors.blueAccent),),
                onPressed: (){
                  var id = _idTextController.value.text;
                  var pw = _pwTextController.value.text;
                  var pwCheck = _pwCheckController.value.text;
                  if(id.length >=4 && pw.length >=6){
                    if(pw == pwCheck){
                      var bytes = utf8.encode(pw);
                      var digest = sha1.convert(bytes);
                      _reference.child(id).push().set(mUser(id, digest.toString(), DateTime.now().toString()).toJson())
                      .then((_) => {Navigator.of(context).pop()});
                    } else {
                      MessageDialogHelper.MakeDialog(context, '비밀번호가 틀립니다.');
                    }
                  } else{
                    MessageDialogHelper.MakeDialog(context, '길이가 짧습니다.');
                  }
                }, )
            ],
          ),
        ),
      ),
    );
  }
}
