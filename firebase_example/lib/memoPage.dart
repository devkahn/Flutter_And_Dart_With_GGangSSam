import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'memo.dart';
import 'memoAdd.dart';
import 'memoDetail.dart';


class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  late FirebaseDatabase _database;
  late DatabaseReference reference;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String _databaseURL = 'https://example-625cb-default-rtdb.firebaseio.com/';
  List<Memo> memos = [];
  
  
  
  BannerAd bannerAd = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      listener: (MobileAdEvent event){
        print('$event');
      }
  );


  @override
  void initState(){
    super.initState();
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-2474169828212841~3064808112');
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database.ref('memo');

    reference.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });

    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if(message != null){
        print(message);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      RemoteNotification? notification = message!.notification;
      AndroidNotification? android = message.notification?.android!;

      if(notification != null && android != null){
         print('onMessage: ${message!}');
         showDialog(
             context: context,
             builder: (context) => AlertDialog(
               content: ListTile(
                 title: Text(message.notification!.title.toString()),
                 subtitle: Text(message.notification!.body.toString()),
               ),
               actions: [
                 TextButton(
                     child: Text('OK'),
                     onPressed: () => Navigator.of(context).pop(),
                 )
               ],
             )
         );
      }
    });

    bannerAd..load()..show(
      anchorOffset: 0,
      anchorType: AnchorType.bottom
    );





  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메모 앱'),),
      body: Container(
        child: Center(
          child: memos.length ==0 ? CircularProgressIndicator() :
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index){
                return Card(
                  child: GridTile(
                    child: Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        child: GestureDetector(
                          onTap: () async {
                            //TODO:메모 상세보기 화면으로 이동 추가 예정
                            Memo memo = await Navigator.of(context).push(MaterialPageRoute<Memo>(
                                builder: (BuildContext context) => MemoDetailPage(reference, memos[index]))) as Memo;
                            if(memo != null){
                              setState(() {
                                memos[index].title = memo.title;
                                memos[index].content = memo.content;
                              });
                            }

                          },
                          onLongPress: () => DeleteMemo(index),
                          child: Text(memos[index].content),
                        ),
                      ),
                    ),
                    header:  Text(memos[index].title),
                    footer: Text(memos[index].createTime.substring(0,10)),
                  ),
                );
              },
              itemCount: memos.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MemoAddPage(reference)));
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void DeleteMemo(int index){
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,


        builder: (context){
          return       AlertDialog(
            actionsAlignment: MainAxisAlignment.spaceAround,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(memos[index].title),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('삭제하시겠습니까?'),
              ],
            ),
            actions: [
              TextButton(
                child: Text('예'),
                onPressed: (){
                  reference.child(memos[index].key).remove()
                      .then((_){
                    setState(() {
                      memos.removeAt(index);
                      Navigator.of(context).pop();
                    });
                  });
                }, ),
              TextButton(
                child: Text('아니오'),
                onPressed: (){
                  Navigator.of(context).pop();
                }, ),
            ],
          );
        });
  }
}

