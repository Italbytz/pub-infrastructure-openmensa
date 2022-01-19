// To parse this JSON data, do
//
//     final day = dayFromJson(jsonString);

import 'dart:convert';

List<Day> daysFromJson(String str) =>
    List<Day>.from(json.decode(str).map((x) => Day.fromJson(x)));

String daysToJson(List<Day> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Day {
  Day({
    required this.date,
    required this.closed,
  });

  DateTime date;
  bool closed;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        date: DateTime.parse(json["date"]),
        closed: json["closed"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "closed": closed,
      };
}
