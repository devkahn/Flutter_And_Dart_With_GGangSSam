class Todo{
  late String title;
  late String content;
  late bool active;
  int? id;

  Todo({required this.title, required this.content, required this.active, this.id});

  Map<String, dynamic> toMap(){
    return{
      'id' : id,
      'title' : title,
      'content' :  content,
      'active' : active,
    };
  }
}