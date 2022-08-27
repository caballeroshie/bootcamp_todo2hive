import 'dart:convert';

class ItemModel {
  final String title;
  final String desc;
  final String date;

  ItemModel({
    required this.title,
    required this.desc,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'date': date,
    };
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      title: json['title'],
      desc: json['desc'],
      date: json['date'],
    );
  }
}








// class ItemModel {
//   final String title;
//   final String desc;
//   final String date;

//   ItemModel({
//     required this.title,
//     required this.desc,
//     required this.date,
//   });
// }
