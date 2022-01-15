// To parse this JSON data, do
//
//     final injectionRegistrant = injectionRegistrantFromJson(jsonString);

import 'dart:convert';

class InjectionRegistrant {
  InjectionRegistrant({
    required this.count,
    required this.list,
    required this.log,
    required this.result,
  });

  int count;
  List<ListElement> list;
  List<dynamic> log;
  String result;

  factory InjectionRegistrant.fromRawJson(String str) => InjectionRegistrant.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InjectionRegistrant.fromJson(Map<String, dynamic> json) => InjectionRegistrant(
    count: json["count"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
    log: List<dynamic>.from(json["log"].map((x) => x)),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
    "log": List<dynamic>.from(log.map((x) => x)),
    "result": result,
  };
}

class ListElement {
  ListElement({
    required this.id,
    required this.address,
    required this.age,
    required this.illnessHistory,
    required this.name,
    required this.nextExpectedShotDate,
    required this.nextExpectedShotType,
    required this.priorityGroup,
    required this.sex,
  });

  String id;
  Address address;
  double age;
  bool illnessHistory;
  String name;
  DateTime nextExpectedShotDate;
  String nextExpectedShotType;
  int priorityGroup;
  bool sex;

  factory ListElement.fromRawJson(String str) => ListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    id: json["_id"],
    address: Address.fromJson(json["address"]),
    age: json["age"].toDouble(),
    illnessHistory: json["illness_history"],
    name: json["name"],
    nextExpectedShotDate: DateTime.parse(json["next_expected_shot_date"]),
    nextExpectedShotType: json["next_expected_shot_type"],
    priorityGroup: json["priority_group"],
    sex: json["sex"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "address": address.toJson(),
    "age": age,
    "illness_history": illnessHistory,
    "name": name,
    "next_expected_shot_date": nextExpectedShotDate.toIso8601String(),
    "next_expected_shot_type": nextExpectedShotType,
    "priority_group": priorityGroup,
    "sex": sex,
  };
}

class Address {
  Address({
    required this.district,
    required this.province,
    required this.stNo,
    required this.ward,
  });

  String district;
  String province;
  String stNo;
  String ward;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    district: json["district"],
    province: json["province"],
    stNo: json["st_no"],
    ward: json["ward"],
  );

  Map<String, dynamic> toJson() => {
    "district": district,
    "province": province,
    "st_no": stNo,
    "ward": ward,
  };
}
