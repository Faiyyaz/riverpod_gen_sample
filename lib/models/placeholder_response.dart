import 'dart:convert';

List<CustomPlaceholder> customPlaceholderResponseFromJson(String str) =>
    List<CustomPlaceholder>.from(
        json.decode(str).map((x) => CustomPlaceholder.fromJson(x)));

class CustomPlaceholder {
  int userId;
  int id;
  String title;
  bool completed;

  CustomPlaceholder({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory CustomPlaceholder.fromJson(Map<String, dynamic> json) =>
      CustomPlaceholder(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
