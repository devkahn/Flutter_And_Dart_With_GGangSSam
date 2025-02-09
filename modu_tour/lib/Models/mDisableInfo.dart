import 'package:firebase_database/firebase_database.dart';


class mDisableInfo{
  late String Key;
  late int Disable1;
  late int Disable2;
  late String Id;
  late String CreatedTime;

  mDisableInfo(this.Id, this.Disable1, this.Disable2){
    CreatedTime = DateTime.now().toString();
  }

  mDisableInfo.FromSnapshot(DataSnapshot snst){
    Map<Object?, Object?> map = snst.value as Map<Object?, Object?>;
    Key = snst.key!;
    Disable1 = int.parse(map['Disable1'].toString());
    Disable2 = int.parse(map['Disable2'].toString());
    Id = map['Id'].toString();
    CreatedTime = map['CreatedTime'].toString();
  }

  ToJson(){
    return {'Id' : Id, 'Disable1' :  Disable1, 'Disable2' : Disable2, 'CreatedTime' : CreatedTime };
  }

}