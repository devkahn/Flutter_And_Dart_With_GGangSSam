import 'package:firebase_database/firebase_database.dart';


class mUser{
  String? Key;
  late String Id;
  late String Password;
  late String CreatedDate;

  mUser(this.Id, this.Password, this.CreatedDate);

  mUser.fromSnaphot(DataSnapshot snst){
    Map<Object?, Object?> map =snst.value as Map<Object?, Object?>;
    Key = snst.key!;
    Id =map['Id'].toString();
    Password = map['Password'].toString();
    CreatedDate = map['CreatedDate'].toString();
  }

  toJson(){
    return {'Id' :Id, 'Password' : Password, 'CreatedData' : CreatedDate};
  }

}