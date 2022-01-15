// To parse this JSON data, do
//
//     final createCampaign = createCampaignFromJson(jsonString);

import 'dart:convert';

class CreateCampaign {
  CreateCampaign({
    required this.campaignId,
    required this.count,
    required this.log,
    required this.result,
    required this.val,
  });

  String campaignId;
  int count;
  List<dynamic> log;
  String result;
  Val val;

  factory CreateCampaign.fromRawJson(String str) =>
      CreateCampaign.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateCampaign.fromJson(Map<String, dynamic> json) => CreateCampaign(
        campaignId: json["campaign_id"],
        count: json["count"],
        log: List<dynamic>.from(json["log"].map((x) => x)),
        result: json["result"],
        val: Val.fromJson(json["val"]),
      );

  Map<String, dynamic> toJson() => {
        "campaign_id": campaignId,
        "count": count,
        "log": List<dynamic>.from(log.map((x) => x)),
        "result": result,
        "val": val.toJson(),
      };
}

class Val {
  Val({
    required this.dateEnd,
    required this.datePlace,
    required this.dateStart,
    required this.listOfPeople,
    required this.name,
    required this.status,
    required this.typeOfPeople,
  });

  DateTime dateEnd;
  String datePlace;
  DateTime dateStart;
  List<ListOfPerson> listOfPeople;
  String name;
  bool status;
  TypeOfPeople typeOfPeople;

  factory Val.fromRawJson(String str) => Val.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Val.fromJson(Map<String, dynamic> json) => Val(
        dateEnd: DateTime.parse(json["date_end"]),
        datePlace: json["date_place"],
        dateStart: DateTime.parse(json["date_start"]),
        listOfPeople: List<ListOfPerson>.from(
            json["list_of_people"].map((x) => ListOfPerson.fromJson(x))),
        name: json["name"],
        status: json["status"],
        typeOfPeople: TypeOfPeople.fromJson(json["type_of_people"]),
      );

  Map<String, dynamic> toJson() => {
        "date_end": dateEnd.toIso8601String(),
        "date_place": datePlace,
        "date_start": dateStart.toIso8601String(),
        "list_of_people":
            List<dynamic>.from(listOfPeople.map((x) => x.toJson())),
        "name": name,
        "status": status,
        "type_of_people": typeOfPeople.toJson(),
      };
}

class ListOfPerson {
  ListOfPerson({
    required this.id,
    required this.address,
    required this.age,
    required this.illnessHistory,
    required this.lastShot,
    required this.name,
    required this.nextExpectedShotDate,
    required this.nextExpectedShotType,
    required this.priorityGroup,
    required this.sex,
    required this.vaccineShots,
  });

  String id;
  ListOfPersonAddress address;
  double age;
  bool illnessHistory;
  Shot lastShot;
  String name;
  DateTime nextExpectedShotDate;
  String nextExpectedShotType;
  int priorityGroup;
  bool sex;
  List<Shot> vaccineShots;

  factory ListOfPerson.fromRawJson(String str) =>
      ListOfPerson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOfPerson.fromJson(Map<String, dynamic> json) => ListOfPerson(
        id: json["_id"],
        address: ListOfPersonAddress.fromJson(json["address"]),
        age: json["age"].toDouble(),
        illnessHistory: json["illness_history"],
        lastShot: Shot.fromJson(json["last_shot"]),
        name: json["name"],
        nextExpectedShotDate: DateTime.parse(json["next_expected_shot_date"]),
        nextExpectedShotType: json["next_expected_shot_type"],
        priorityGroup: json["priority_group"],
        sex: json["sex"],
        vaccineShots:
            List<Shot>.from(json["vaccine_shots"].map((x) => Shot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address.toJson(),
        "age": age,
        "illness_history": illnessHistory,
        "last_shot": lastShot.toJson(),
        "name": name,
        "next_expected_shot_date": nextExpectedShotDate.toIso8601String(),
        "next_expected_shot_type": nextExpectedShotType,
        "priority_group": priorityGroup,
        "sex": sex,
        "vaccine_shots":
            List<dynamic>.from(vaccineShots.map((x) => x.toJson())),
      };
}

class ListOfPersonAddress {
  ListOfPersonAddress({
    required this.district,
    required this.province,
    required this.stNo,
    required this.ward,
  });

  String district;
  String province;
  String stNo;
  String ward;

  factory ListOfPersonAddress.fromRawJson(String str) =>
      ListOfPersonAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOfPersonAddress.fromJson(Map<String, dynamic> json) =>
      ListOfPersonAddress(
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

class Shot {
  Shot({
    required this.shotDate,
    required this.shotNum,
    required this.shotPlace,
    required this.status,
    required this.typeName,
  });

  DateTime shotDate;
  int shotNum;
  String shotPlace;
  String status;
  String typeName;

  factory Shot.fromRawJson(String str) => Shot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shot.fromJson(Map<String, dynamic> json) => Shot(
        shotDate: DateTime.parse(json["shot_date"]),
        shotNum: json["shot_num"],
        shotPlace: json["shot_place"],
        status: json["status"],
        typeName: json["type_name"],
      );

  Map<String, dynamic> toJson() => {
        "shot_date": shotDate.toIso8601String(),
        "shot_num": shotNum,
        "shot_place": shotPlace,
        "status": status,
        "type_name": typeName,
      };
}

class TypeOfPeople {
  TypeOfPeople({
    required this.address,
    required this.ageRange,
    required this.dateOfShotExpect,
    required this.nextVaccineType,
    required this.priorityGroup,
  });

  TypeOfPeopleAddress address;
  String ageRange;
  DateOfShotExpect dateOfShotExpect;
  String nextVaccineType;
  int priorityGroup;

  factory TypeOfPeople.fromRawJson(String str) =>
      TypeOfPeople.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypeOfPeople.fromJson(Map<String, dynamic> json) => TypeOfPeople(
        address: TypeOfPeopleAddress.fromJson(json["address"]),
        ageRange: json["age_range"],
        dateOfShotExpect:
            DateOfShotExpect.fromJson(json["date_of_shot_expect"]),
        nextVaccineType: json["next_vaccine_type"],
        priorityGroup: json["priority_group"],
      );

  Map<String, dynamic> toJson() => {
        "address": address.toJson(),
        "age_range": ageRange,
        "date_of_shot_expect": dateOfShotExpect.toJson(),
        "next_vaccine_type": nextVaccineType,
        "priority_group": priorityGroup,
      };
}

class TypeOfPeopleAddress {
  TypeOfPeopleAddress({
    required this.province,
  });

  String province;

  factory TypeOfPeopleAddress.fromRawJson(String str) =>
      TypeOfPeopleAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypeOfPeopleAddress.fromJson(Map<String, dynamic> json) =>
      TypeOfPeopleAddress(
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "province": province,
      };
}

class DateOfShotExpect {
  DateOfShotExpect({
    required this.endDate,
    required this.startDate,
  });

  DateTime endDate;
  DateTime startDate;

  factory DateOfShotExpect.fromRawJson(String str) =>
      DateOfShotExpect.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DateOfShotExpect.fromJson(Map<String, dynamic> json) =>
      DateOfShotExpect(
        endDate: DateTime.parse(json["end_date"]),
        startDate: DateTime.parse(json["start_date"]),
      );

  Map<String, dynamic> toJson() => {
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
      };
}
