import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';
import 'addTodoApp.dart';
import 'clearList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Future<Database> database = initDatabase();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( primarySwatch: Colors.blue, ),
      initialRoute: '/',
      routes: {
        '/' : (context) => DatabaseApp(database),
        '/add' : (context) => AddTodoApp(database),
        '/clear' : (context) => ClearListAPP(database)
      },
    );
  }


  Future<Database> initDatabase() async {
    return openDatabase(
        join(await getDatabasesPath(), 'todo_database.db'),
        onCreate: (db, version){
          db.execute("CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content, TEXT, active BOOL)");
          return db;
        },
        version: 1
    );
  }

}

class DatabaseApp extends StatefulWidget {
  final Future<Database> db;

  DatabaseApp(this.db);



  @override
  State<DatabaseApp> createState() => _DatabaseAppState();
}

class _DatabaseAppState extends State<DatabaseApp> {
  late Future<List<Todo>> todoList ;

  @override
  void initState(){
    super.initState();
    todoList = getTodos();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Example'),
        actions: [
          TextButton(
              onPressed: () async {
                await Navigator.of(context).pushNamed('/clear');
                setState(() {
                  todoList = getTodos();
                });
              },
              child: Text('완료한 일', style: TextStyle(color: Colors.white),)
          )
        ],
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            builder: (context, snapshot) {
              switch (snapshot.connectionState){
                case ConnectionState.none: return CircularProgressIndicator();
                case ConnectionState.waiting: return CircularProgressIndicator();
                case ConnectionState.active: return CircularProgressIndicator();
                case ConnectionState.done:
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
                                  Text('체크 : ${todo.active.toString()}'),
                                  Container( height: 1, color: Colors.blue,)
                                ],
                              ),
                            ),
                            onTap: () async{
                              TextEditingController controller = new TextEditingController(text: todo.content);
                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text('${todo.id} : ${todo.title}'),
                                      content: TextField(
                                        controller: controller,
                                        keyboardType: TextInputType.text,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              setState(() {
                                                todo.active = true? todo.active =false :  todo.active = true;
                                                todo.content = controller.value.text;
                                              });
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: Text('예')
                                        ),
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니오')
                                        )
                                      ],
                                    );
                                  }
                              );
                              if(result != null){
                                _updateTodo(result);
                              }
                            },
                            onLongPress: () async{
                              Todo result = await showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text('${todo.id} : ${todo.title}'),
                                      content: Text('${todo.content}를 삭제하시겠습니까?'),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).pop(todo);
                                            },
                                            child: Text('예')),
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('아니오'))
                                      ],
                                    );
                                  }
                              );
                              if(result !=null){
                                _deleteTodo(result);
                              }
                            },

                          );
                        },
                      itemCount: snapshot.data!.length,
                    );
                  } else{
                    return Text('No Data');
                  }
              }
              return CircularProgressIndicator();
            },
            future: todoList,
          ),
        ),
      ),
      floatingActionButton:  Column(
        mainAxisAlignment:  MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final todo = await Navigator.of(context).pushNamed('/add') as Todo;
              if( todo != null) _insertTodo(todo);
            },
            heroTag: null,
            child: Icon(Icons.add),
          ),
          SizedBox( height: 10,),
          FloatingActionButton(
              onPressed: () async{
                _allUpdate();
              },
            heroTag: null,
            child: Icon(Icons.update),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }


  void _insertTodo(Todo todo) async{
    final Database database = await widget.db;
    await database.insert('todos', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    setState(() {
      todoList = getTodos();
    });
  }

  void _updateTodo(Todo todo) async {
    final Database database = await widget.db;
    await database.update('todos', todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });
  }

  void _allUpdate() async {
    final Database database = await widget.db;
    await database.rawUpdate('UPDATE todos SET active = 1 WHERE active = 0');
    setState(() {
      todoList = getTodos();
    });

  }

  void _deleteTodo(Todo todo) async{
    final Database database = widget.db as Database;
    await database.delete('todos', where: 'id=?', whereArgs: [todo.id]);
    setState(() {
      todoList = getTodos();
    });

  }

  Future<List<Todo>> getTodos() async {
    final Database database = await widget.db;
    final List<Map<String, dynamic>> maps = await database.query('todos');
    print(maps);

    return List.generate(maps.length, (i) {
      bool active = maps[i]['active'] == 1 ? true : false;
      return Todo(title: maps[i]['title'], content: maps[i]['content'], active: active, id: maps[i]['id']);
    });
  }
}
