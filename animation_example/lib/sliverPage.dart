import 'package:flutter/material.dart';
import 'dart:math' as math;

class SliverPage extends StatefulWidget {
  const SliverPage({Key? key}) : super(key: key);

  @override
  State<SliverPage> createState() => _SliverPageState();
}

class _SliverPageState extends State<SliverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150.0,
            flexibleSpace:  FlexibleSpaceBar(
              title: Text('Sliver Example'),
              background: Image.asset('repo/images/sunny.png'),
            ),
            backgroundColor: Colors.deepOrangeAccent,
            pinned: true,
          ),
          SliverPersistentHeader(
              delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Column(
                      mainAxisAlignment:  MainAxisAlignment.center,
                      children: [
                        Text('list 숫자', style: TextStyle(fontSize: 30),)
                      ],
                    ),
                  ),
                )
              ),
            pinned: true,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
                customCard('5'),
                customCard('6'),
                customCard('7'),
                customCard('8'),

              ])
          ),
          SliverPersistentHeader(
              delegate: _HeaderDelegate(
                minHeight: 50,
                maxHeight: 150,
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('그리드 숫자', style: TextStyle(fontSize: 30),)
                      ],
                    ),
                  ),
                )
              ),
            pinned: true,
          ),
          SliverGrid(
              delegate: SliverChildListDelegate([
                customCard('1'),
                customCard('2'),
                customCard('3'),
                customCard('4'),
                customCard('5'),
                customCard('6'),
                customCard('7'),
                customCard('8'),
              ]),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Container(
                  child: customCard('list count : $index'),
                );
              },childCount: 10,
              )
          )


        ],
      ),
    );
  }

  Widget customCard(String text){
    return Card(
      child: Container(
        height: 120,
        child:  Center(
          child: Text(text, style: TextStyle(fontSize: 40),),
        ),
      ),
    );
  }
}


class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({required this.minHeight, required this.maxHeight, required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate){
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }

}
