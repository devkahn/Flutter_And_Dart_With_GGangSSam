import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Widget Example';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}


class WidgetApp extends StatefulWidget {
  const WidgetApp({Key? key}) : super(key: key);

  @override
  State<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItems = [];
  String _buttonText ='';

  @override
  void initState(){
    super.initState();
    for(var item in _buttonList){
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    _buttonText = _dropDownMenuItems[0].value.toString();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Widget Example')
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text('결과 : $sum', style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value1,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextField(keyboardType: TextInputType.number, controller: value2,),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      var result;

                      if( _buttonText == _buttonList[0]){
                        result = value1Int + value2Int;
                      }
                      else if (_buttonText == _buttonList[1]){
                        result = value1Int - value2Int;
                      }
                      else if(_buttonText == _buttonList[2]){
                        result = value1Int*value2Int;
                      }
                      else if (_buttonText == _buttonList[3]){
                        result = value1Int/value2Int;
                      }



                      sum = '$result';
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(_buttonText)
                    ],
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(15),
                  child: DropdownButton(items: _dropDownMenuItems, onChanged: (value){
                    setState(() {
                      _buttonText = value.toString();
                    });
                  }, value: _buttonText,)
              )
            ],
          ),
        ),
      ),
    );
  }
}



