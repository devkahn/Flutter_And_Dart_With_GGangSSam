import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'memo.dart';

class MemoDetailPage extends StatefulWidget {
  final DatabaseReference reference;
  final Memo memo;

  MemoDetailPage(this.reference, this.memo);

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController(text: widget.memo.title);
    _contentController = TextEditingController(text: widget.memo.content);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.memo.title),),
      body: Container(
        padding: EdgeInsets.all(20),
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
                child: Text('수정하기'),
                style: ButtonStyle(
                    shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1)
                        )
                    )
                ),
                onPressed: (){
                  Memo memo = Memo(_titleController.value.text, _contentController.value.text, widget.memo.createTime);
                  widget.reference.child(widget.memo.key).set(memo.toJson())
                  .then((_) => Navigator.of(context).pop(memo));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
