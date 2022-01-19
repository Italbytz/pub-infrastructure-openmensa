// To parse this JSON data, do
//
//     final canteen = canteenFromJson(jsonString);

import 'dart:convert';

List<Canteen> canteensFromJson(String str) =>
    List<Canteen>.from(json.decode(str).map((x) => Canteen.fromJson(x)));

String canteensToJson(List<Canteen> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Canteen {
  Canteen({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    this.coordinates,
  });

  int id;
  String name;
  String city;
  String address;
  List<double>? coordinates;

  factory Canteen.fromJson(Map<String, dynamic> json) => Canteen(
        id: json["id"],
        name: json["name"],
        city: json["city"],
        address: json["address"],
        coordinates: json["coordinates"] == null
            ? null
            : List<double>.from(json["coordinates"]!.map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "address": address,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
