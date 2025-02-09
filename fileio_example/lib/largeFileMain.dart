import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


class largeFileMain extends StatefulWidget {
  const largeFileMain({Key? key}) : super(key: key);

  @override
  State<largeFileMain> createState() => _largeFileMainState();
}

class _largeFileMainState extends State<largeFileMain> {
  final imgUrl = 'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress';
  bool downloading = false;
  var progressString ='';
   var file;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Large File Example'),
      ),
      body: Center(
        child:  downloading
            ? Container(
              height: 120.0,
              width: 200.0,
              child: Card(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Downloading File : $progressString',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
          
              )
            : FutureBuilder(
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                      print('none');
                      return Text('데이터 없음');
                    case ConnectionState.waiting:
                      print('waiting');
                      return CircularProgressIndicator();
                    case ConnectionState.active:
                      print('active');
                      return CircularProgressIndicator();
                    case ConnectionState.done:
                      print('done');
                      if (snapshot.hasData) return snapshot.data as Widget;
                  }
                  print('end process');
                  return Text('데이터 없음');
                },
          future: downloadWidget(file),
        )
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){ downloadFile(); },
        child: Icon(Icons.file_download),
      )
    );
  }


  Future<void> downloadFile() async{
    Dio dio = Dio();
    try{
      var dir = await getApplicationDocumentsDirectory(); //path_provider 패키지가 제공
      print('dir : $dir');
      await dio.download(imgUrl, '${dir.path}/myimage.jpg', onReceiveProgress: (rec, total){
        print('Rec: $rec, Total: %total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString =((rec/total) *100).toStringAsFixed(0) +'%';
        });
      });
    } catch (e){
      print(e);
    }
    setState(() {
      downloading = false;
      progressString ='Completed';
    });
    print('Download completed');
  }


  Future<Widget> downloadWidget(String? filePath) async{

    print('filepath : $filePath');
    if(filePath  == null) return Text('No Data');

    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict();

    if(exist){
      return Center(
        child:  Column(
          children: [
            Image.file(File(filePath))
          ],

        ),
      );
    } else {
      return Text('No Data');
    }

  }

}
