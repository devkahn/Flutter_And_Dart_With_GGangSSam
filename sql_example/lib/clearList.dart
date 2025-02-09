import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'todo.dart';

class ClearListAPP extends StatefulWidget {
  Future<Database> database;
  ClearListAPP(this.database);

  @override
  State<ClearListAPP> createState() => _ClearListAPPState();
}

class _ClearListAPPState extends State<ClearListAPP> {
  late Future<List<Todo>> clearList;


  @override
  void initState(){
    super.initState();
    clearList = getClearList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('완료한 일'),
      ),
      body: Container(
        child:  Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch(snapshot.connectionState){
                case ConnectionState.none : return CircularProgressIndicator();
                case ConnectionState.waiting : return CircularProgressIndicator();
                case ConnectionState.active : return CircularProgressIndicator();
                case ConnectionState.done :
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemBuilder: (context, index){
                        Todo todo = snapshot.data![index];
                            return ListTile(
                              title: Text(todo.title, style: TextStyle(fontSize: 20),),
                              subtitle: Container(
                                child: Column(
                                  children: [
                                    Text(todo.content),
                                    Container(height: 1, color: Colors.blue,)
                                  ],
                                ),
                              ),
                            );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  }
              }
              return Text('No Data');
            },
            future: clearList,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final result = await showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                  title: Text('완료한 일 삭제'),
                  content:  Text('완료한 일을 모두 삭제할까요?'),
                  actions: [
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pop(true);
                        },
                        child: Text('예')
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.of(context).pop(false);
                        },
                        child: Text('아니오')
                    )
                  ],
                );
              }
          );
          if(result == true){
            _removeAllTodos();
          }
        },
        child:  Icon(Icons.remove),
      ),
    );
  }

  Future<List<Todo>> getClearList() async{
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database.rawQuery('SELECT title, content, id FROM todos WHERE active =1');

    return List.generate(maps.length, (i) {
      return Todo(
        title:  maps[i]['title'].toString(),
    content: maps[i]['content'].toString(),
    id: maps[i]['id'],
    active: true
    );

    });
  }

  void _removeAllTodos() async{
    final Database database = await widget.database;
    database.rawDelete('DELETE FROM todos WHERE active=1');
    setState(() {
      clearList = getClearList();
    });
  }

}
