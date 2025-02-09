import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';

class MemoAddPage extends StatefulWidget {
  final DatabaseReference reference;
  MemoAddPage(this.reference);

  @override
  State<MemoAddPage> createState() => _MemoAddPageState();
}

class _MemoAddPageState extends State<MemoAddPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  InterstitialAd fullPageAdvertise = InterstitialAd(
    adUnitId: InterstitialAd.testAdUnitId,
    listener: (MobileAdEvent event){
      print('$event');
    }

  );

  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('메모 추가'),),
      body: Container(
        padding:  EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: '제목', fillColor: Colors.blueAccent),
              ),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 100,
                  decoration: InputDecoration(labelText: '내용'),
                )),
              TextButton(
                  child: Text('저장하기'),
                  style: ButtonStyle(
                      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1)
                        )
                      )
                  ),
                  onPressed: (){
                    widget.reference.push().set(
                      Memo(_titleController.value.text, _contentController.value.text, DateTime.now().toIso8601String()).toJson())
                        .then((_) => {Navigator.of(context).pop()});
                    fullPageAdvertise..load()..show(
                      anchorType: AnchorType.bottom,
                      anchorOffset: 0.0,
                    );
                  }, )
            ],
          ),
        ),
      ),
    );
  }
}
