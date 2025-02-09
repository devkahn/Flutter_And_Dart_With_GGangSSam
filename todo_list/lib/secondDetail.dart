import 'package:flutter/material.dart';

class SecondDetail extends StatelessWidget {
  const SecondDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop(controller.value.text);
                  },
                  child: Text('저장하기')
              )
            ],
          )
        ),
      ),
    );
  }
}
