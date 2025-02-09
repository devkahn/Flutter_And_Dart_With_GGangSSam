import 'package:flutter/cupertino.dart';
import 'animalItem.dart';
import 'iOSSub/cupertinoFirstPage.dart';
import 'iOSSub/cupertinoSecondPage.dart';

class CupertinoMain extends StatefulWidget {
  const CupertinoMain({Key? key}) : super(key: key);

  @override
  State<CupertinoMain> createState() => _CupertinoMainState();
}

class _CupertinoMainState extends State<CupertinoMain> {
  late CupertinoTabBar tabBar;
  List<Animal> animalList = [];


  @override
  void initState(){
    super.initState();
    tabBar = CupertinoTabBar(items: [
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.add)),
    ],);


    animalList.add(Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png", flyExist: false));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png", flyExist: false));
    animalList.add(Animal(animalName: "젖소", kind: "포유류", imagePath: "repo/images/cow.png", flyExist: false));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png", flyExist: false));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png", flyExist: false));
    animalList.add(Animal(animalName: "원숭이", kind: "포유류", imagePath: "repo/images/monkey.png", flyExist: false));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png", flyExist: false));
    animalList.add(Animal(animalName: "늑대", kind: "포유류", imagePath: "repo/images/wolf.png", flyExist: false));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoTabScaffold(
        tabBar: tabBar,
        tabBuilder: (context, value) {
          if (value == 0){
            return CupertinoFirstPage(animalList: animalList);
          } else{
            return CupertinoSecondPage(animalList: animalList);
          }

        }
      ),
    );
  }
}
