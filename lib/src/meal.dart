// To parse this JSON data, do
//
//     final meal = mealFromJson(jsonString);

import 'dart:convert';

List<Meal> mealsFromJson(String str) =>
    List<Meal>.from(json.decode(str).map((x) => Meal.fromJson(x)));

String mealsToJson(List<Meal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Meal {
  Meal({
    required this.id,
    required this.name,
    required this.category,
    required this.prices,
    required this.notes,
  });

  int id;
  String name;
  String category;
  Price prices;
  List<String> notes;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        prices: Price.fromJson(json["prices"]),
        notes: List<String>.from(json["notes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "prices": prices.toJson(),
        "notes": List<dynamic>.from(notes.map((x) => x)),
      };
}

class Price {
  Price({this.students, this.employees, this.pupils, this.others});

  double? students;
  double? employees;
  double? pupils;
  double? others;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        students: json["students"]?.toDouble(),
        employees: json["employees"]?.toDouble(),
        pupils: json["pupils"]?.toDouble(),
        others: json["others"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "students": students,
        "employees": employees,
        "pupils": pupils,
        "others": others,
      };
}
