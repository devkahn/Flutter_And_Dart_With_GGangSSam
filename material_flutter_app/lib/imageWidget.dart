import 'package:flutter/material.dart';

class ImageWidgetApp extends StatefulWidget {
  const ImageWidgetApp({Key? key}) : super(key: key);

  @override
  State<ImageWidgetApp> createState() => _ImageWidgetAppState();
}

class _ImageWidgetAppState extends State<ImageWidgetApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Widget'),),
      body: Container(
        child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset('images/flutter1.png', width: 200, height: 200, fit: BoxFit.fill,),
               Text('Hello Flutter',
               style: TextStyle(fontFamily: 'Pacifico', fontSize: 30, color: Colors.blue),)
             ],
           ),
        ),
      ),
    );
  }
}
