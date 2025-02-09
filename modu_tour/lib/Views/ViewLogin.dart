import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modu_tour/Defines/Defines.dart';
import 'package:modu_tour/Helpers/MessageDialogHelper.dart';
import 'package:modu_tour/Models/mUser.dart';


class ViewLogin extends StatefulWidget {
  const ViewLogin({Key? key}) : super(key: key);

  @override
  State<ViewLogin> createState() => _ViewLoginState();
}

class _ViewLoginState extends State<ViewLogin> with SingleTickerProviderStateMixin {
  late FirebaseDatabase _database;
  late DatabaseReference _ref;

  double opacity = 0;
  late AnimationController _animationController;
  late Animation _animation;
  late TextEditingController _idTextController;
  late TextEditingController _pwTextController;

  @override
  void initState(){
    super.initState();

    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();

    _animationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = Tween<double>(begin: 0, end: pi*2).animate(_animationController);
    _animationController.repeat();
    Timer(Duration(seconds: 2), () {
      setState(() {
        opacity=1;
      });
    });

    _database = FirebaseDatabase(databaseURL: Defines.BASE_URL);
    _ref = _database.ref().child(Defines.TABLE_NAME_USER);
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, widget){
                    return Transform.rotate(
                      angle: _animation.value,
                      child: widget,
                    );
                  },
                child: Icon(Icons.airplanemode_active, color: Colors.deepOrangeAccent, size: 80,),
              ),
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(Defines.APP_NAME, style: TextStyle(fontSize: 30),),
                ),
              ),
              AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(seconds: 1),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                          child: TextField(
                            controller: _idTextController,
                            maxLines: 1,
                            decoration: InputDecoration(labelText: 'ID', border: OutlineInputBorder()),
                          ),
                      ),
                      SizedBox(height: 20,),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          controller: _pwTextController,
                          obscureText: true,
                          maxLines: 1,
                          decoration: InputDecoration(labelText: 'PW', border: OutlineInputBorder()),
                        ),
                      )
                    ],
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Text('회원가입'),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Defines.PAGE_NAME_SIGN);
                    }
                  ),
                  TextButton(
                    child: Text('로그인'),
                    onPressed: () {
                      var id = _idTextController.value.text;
                      var pw = _pwTextController.value.text;
                      if(id.length == 0 || pw.length == 0) MessageDialogHelper.MakeDialog(context, '빈칸이 있습니다.');
                          else{
                            _ref.child(id).onValue.listen((event) {
                              if(event.snapshot.value == null) MessageDialogHelper.MakeDialog(context, '아이디가 없습니다.');
                                  else{
                                    _ref.child(id).onChildAdded.listen((event) {
                                      mUser user = mUser.fromSnaphot(event.snapshot);
                                      var bytes = utf8.encode(pw);
                                      var digest = sha1.convert(bytes);
                                      if(user.Password == digest.toString()){
                                        Navigator.of(context).pushReplacementNamed(Defines.PAGE_NAME_MAIN, arguments: id);
                                      } else{
                                        MessageDialogHelper.MakeDialog(context, '비밀번호가 틀립니다.');
                                      }

                                    });
                              }
                            });
                      }


      }, )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
