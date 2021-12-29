// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

class Welcome {
  Welcome({
    required this.id,
    required this.name,
    required this.districts,
  });

  String id;
  String name;
  List<District> districts;

  factory Welcome.fromRawJson(String str) => Welcome.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        id: json["Id"],
        name: json["Name"],
        districts: List<District>.from(
            json["Districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Districts": List<dynamic>.from(districts.map((x) => x.toJson())),
      };
}

class District {
  District({
    required this.id,
    required this.name,
    required this.wards,
  });

  String id;
  String name;
  List<Ward> wards;

  factory District.fromRawJson(String str) =>
      District.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["Id"],
        name: json["Name"],
        wards: List<Ward>.from(json["Wards"].map((x) => Ward.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Wards": List<dynamic>.from(wards.map((x) => x.toJson())),
      };
}

class Ward {
  Ward({
    this.id,
    this.name,
    this.level,
  });

  String? id;
  String? name;
  Level? level;

  factory Ward.fromRawJson(String str) => Ward.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ward.fromJson(Map<String, dynamic> json) => Ward(
        id: json["Id"] == null ? null : json["Id"],
        name: json["Name"] == null ? null : json["Name"],
        level: levelValues.map[json["Level"]],
      );

  Map<String, dynamic> toJson() => {
        "Id": id == null ? null : id,
        "Name": name == null ? null : name,
        "Level": levelValues.reverse[level],
      };
}

enum Level { PHNG, TH_TRN, X, HUYN }

final levelValues = EnumValues({
  "Huyện": Level.HUYN,
  "Phường": Level.PHNG,
  "Thị trấn": Level.TH_TRN,
  "Xã": Level.X
});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  late Map<T, String> reverseMap;

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
