class mTourData{
  late String Title;
  late String Tel;
  late String ZipCode;
  late String Address;
  late var Id;
  late var MapX;
  late var MapY;
  late var ImagePath;

  mTourData(this.Id, this.Title, this.Tel, this.ZipCode, this.Address, this.MapX, this.MapY, this.ImagePath);

  mTourData.FromJson(Map data)
  : Id = data['contentid'],
  Title = data['title'],
  Tel = data['tel'],
  ZipCode = data['zipcode'],
  Address = data['address'],
  MapX = data['mapx'],
  MapY = data['mapy'],
  ImagePath = data['fristimage'];

  Map<String, dynamic> ToMap(){
    return {
      'id' :Id,
      'title' : Title,
      'tel' : Tel,
      'zipcode' : ZipCode,
      'address' : Address,
      'mapx' :MapX,
      'mapy' : MapY,
      'imagePath' : ImagePath,
    };
  }
}