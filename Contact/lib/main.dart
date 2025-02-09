import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('금호동 3가', style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          actions: const [Icon(Icons.search, color: Colors.black,), Icon(Icons.menu, color: Colors.black,), Icon(Icons.notifications_outlined, color: Colors.black,) ],


        ),
        body: SizedBox(
          height: 120,
          child: Row(

            children: [
              Container(
                width: 100, height: 100,margin: EdgeInsets.fromLTRB(10,10,5,10),
                child: Image.asset('3853_1675920047.8219.jpg', width: 95, height: 95, fit: BoxFit.cover, ),
              ),
              ShopItem()
            ],
          ),




        )


      )
    );
  }
}


class ShopItem extends StatelessWidget {
  const ShopItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      width:200, height: 100, margin: EdgeInsets.fromLTRB(5,10,10,10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.start,
            children: const [
              Text("캐논 DSLR 100D(단렌즈, 충전기 16기가SD 포함)",
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),

          Row(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('성동구 행당동', style:TextStyle(color: Colors.grey)),
              Text(' : '),
              Text('끌올 10분 전', style: TextStyle(color: Colors.grey,), ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              Text("210,000원", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.favorite_border_outlined, color: Colors.grey,),
                  Text('4', style: TextStyle(color: Colors.grey),)
                ],
              )
            ],
          )
        ],
      ),

    );
  }
}

