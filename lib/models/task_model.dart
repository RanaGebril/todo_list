class TaskModel {
  String id;
  String title;
  String subTitle;
  bool isDone;
  int date;

  TaskModel(
      {
      //value comes from parameters
      this.id = "",
      required this.title,
      required this.subTitle,
      this.isDone = false,
      required this.date});

  //named constructor
  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            //override default constructor
            //value comes from map
            id: json["id"],
            title: json["title"],
            subTitle: json["subTitle"],
            isDone: json["isDone"],
            date: json["date"],
            );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "subTitle": subTitle,
      "isDone": isDone,
      "date": date,
    };
  }
}
