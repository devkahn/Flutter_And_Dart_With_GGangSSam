class People{
  late String name;
  late double height;
  late double weight;
  late double bmi;

  People(this.name, this.height, this.weight ){
    bmi = weight/((height/100) * (height/100));
  }
}