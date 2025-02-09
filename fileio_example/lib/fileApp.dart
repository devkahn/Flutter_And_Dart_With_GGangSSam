import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FileApp extends StatefulWidget {
  const FileApp({Key? key}) : super(key: key);

  @override
  State<FileApp> createState() => _FileAppState();
}

class _FileAppState extends State<FileApp> {
  int _count =0;
  List<String> itemList =[];
  TextEditingController controller = new TextEditingController();



  Future<List<String>> readListFile() async {
    List<String> itemList = [];

    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstChek = pref.getBool(key);
    var dir = await getApplicationDocumentsDirectory();
    bool fileExist = await File(dir.path +'/fruit.txt').exists();

    if(firstChek == null || firstChek == false || fileExist == false){
      pref.setBool(key, true);
      var file = await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');

      File(dir.path +'/fruit.txt').writeAsStringSync(file);
      var array = file.split('\n');
      for (var item in array){
        print(item);
        itemList.add(item);
      }
    } else {
      var file = await File(dir.path + '/fruit.txt').readAsString();
      var array = file.split('\n');
      for (var item in array){
        print(item);
        itemList.add(item);
      }
    }
    return itemList;
  }



  @override
  void initState(){
    super.initState();
    readCountFile();
    initData();
  }

  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index){
                    return Card(
                      child: Center(
                        child: Text(
                          itemList[index],
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    );
                  },
                  itemCount: itemList.length,
                ),
              )

            ],
          ),
        ),
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: (){
          writeFruit(controller.value.text);
          setState(() {
            itemList.add(controller.value.text);
          });
          writeCountFile(_count);
        },
        child: Icon(Icons.add),
      ),
    );
  }


  void writeCountFile(int count) async{
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path +"\count.txt").writeAsStringSync(count.toString());
  }

  void readCountFile() async {
    try{
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      });
    }catch (e){
      print(e.toString());
    }

  }

  void writeFruit(String fruit) async{
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '\fruit.txt').readAsString();
    file = file +'\n' + fruit;
    File(dir.path +'/fruit.txt').writeAsStringSync(file);
  }

}
