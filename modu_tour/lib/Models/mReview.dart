import 'package:firebase_database/firebase_database.dart';


class mReview {
  late String Key;
  late String Id;
  late String Review;
  late String CreatedTime;

  mReview(this.Id, this.Review, this.CreatedTime);

  mReview.FromSnapshot(DataSnapshot snst){
    Map<Object?, Object?> map = snst.value as Map<Object?, Object?>;
    Key = snst.key!;
    Id = map['Id'].toString();
    Review = map['Review'].toString();
    CreatedTime = map['CreatedTime'].toString();
  }

  ToJson(){
    return {'Id' : Id, 'Review' : Review, 'CreatedTime' : CreatedTime};
  }
}