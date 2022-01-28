// To parse this JSON data, do
//
//     final createCampaign = createCampaignFromJson(jsonString);

import 'dart:convert';

class CreateCampaign {
  CreateCampaign({
    this.campaignId,
    this.count,
    this.log,
    this.result,
    this.val,
  });

  String? campaignId;
  int? count;
  List<dynamic>? log;
  String? result;
  Val? val;

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
        "log": List<dynamic>.from(log!.map((x) => x)),
        "result": result,
        "val": val!.toJson(),
      };
}

class Val {
  Val({
    this.dateEnd,
    this.datePlace,
    this.dateStart,
    this.listOfPeople,
    this.name,
    this.status,
    this.typeOfPeople,
  });

  DateTime? dateEnd;
  String? datePlace;
  DateTime? dateStart;
  List<ListOfPerson>? listOfPeople;
  String? name;
  bool? status;
  TypeOfPeople? typeOfPeople;

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
        "date_end": dateEnd.toString(),
        "date_place": datePlace,
        "date_start": dateStart.toString(),
        "list_of_people":
            List<dynamic>.from(listOfPeople!.map((x) => x.toJson())),
        "name": name,
        "status": status,
        "type_of_people": typeOfPeople!.toJson(),
      };
}

class ListOfPerson {
  ListOfPerson({
    this.id,
    this.address,
    this.age,
    this.illnessHistory,
    this.name,
    this.nextExpectedShotDate,
    this.nextExpectedShotType,
    this.priorityGroup,
    this.sex,
    this.vaccineShots,
    this.lastShot,
  });

  String? id;
  Address? address;
  double? age;
  bool? illnessHistory;
  String? name;
  DateTime? nextExpectedShotDate;
  NextVaccineType? nextExpectedShotType;
  int? priorityGroup;
  bool? sex;
  List<Shot>? vaccineShots;
  Shot? lastShot;

  factory ListOfPerson.fromRawJson(String str) =>
      ListOfPerson.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListOfPerson.fromJson(Map<String, dynamic> json) => ListOfPerson(
        id: json["_id"],
        address: Address.fromJson(json["address"]),
        age: json["age"].toDouble(),
        illnessHistory: json["illness_history"],
        name: json["name"],
        nextExpectedShotDate: DateTime.parse(json["next_expected_shot_date"]),
        nextExpectedShotType:
            nextVaccineTypeValues.map![json["next_expected_shot_type"]],
        priorityGroup: json["priority_group"],
        sex: json["sex"],
        vaccineShots:
            List<Shot>.from(json["vaccine_shots"].map((x) => Shot.fromJson(x))),
        lastShot:
            json["last_shot"] == null ? null : Shot.fromJson(json["last_shot"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "address": address!.toJson(),
        "age": age,
        "illness_history": illnessHistory,
        "name": name,
        "next_expected_shot_date": nextExpectedShotDate.toString(),
        "next_expected_shot_type":
            nextVaccineTypeValues.reverse[nextExpectedShotType],
        "priority_group": priorityGroup,
        "sex": sex,
        "vaccine_shots":
            List<dynamic>.from(vaccineShots!.map((x) => x.toJson())),
        "last_shot": lastShot == null ? null : lastShot!.toJson(),
      };
}

class Address {
  Address({
    this.district,
    this.province,
    this.stNo,
    this.ward,
  });

  District? district;
  Provinces? province;
  String? stNo;
  String? ward;

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        district: json["district"] == null
            ? null
            : districtValues.map![json["district"]],
        province: provinceValues.map![json["province"]],
        stNo: json["st_no"] == null ? null : json["st_no"],
        ward: json["ward"] == null ? null : json["ward"],
      );

  Map<String, dynamic> toJson() => {
        "district": district == null ? null : districtValues.reverse[district],
        "province": provinceValues.reverse[province],
        "st_no": stNo == null ? null : stNo,
        "ward": ward == null ? null : ward,
      };
}

enum District {
  QUN_NG_HNH_SN,
  QUN_CM_L,
  QUN_LIN_CHIU,
  QUN_HI_CHU,
  QUN_THANH_KH,
  QUN_SN_TR,
  HUYN_HA_VANG
}

final districtValues = EnumValues({
  "Huyện Hòa Vang": District.HUYN_HA_VANG,
  "Quận Cẩm Lệ": District.QUN_CM_L,
  "Quận Hải Châu": District.QUN_HI_CHU,
  "Quận Liên Chiểu": District.QUN_LIN_CHIU,
  "Quận Ngũ Hành Sơn": District.QUN_NG_HNH_SN,
  "Quận Sơn Trà": District.QUN_SN_TR,
  "Quận Thanh Khê": District.QUN_THANH_KH
});

enum Provinces { THNH_PH_NNG }

final provinceValues = EnumValues({"Thành phố Đà Nẵng": Provinces.THNH_PH_NNG});

class Shot {
  Shot({
    this.shotDate,
    this.shotNum,
    this.shotPlace,
    this.status,
    this.typeName,
  });

  DateTime? shotDate;
  int? shotNum;
  String? shotPlace;
  Status? status;
  NextVaccineType? typeName;

  factory Shot.fromRawJson(String str) => Shot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Shot.fromJson(Map<String, dynamic> json) => Shot(
        shotDate: DateTime.parse(json["shot_date"]),
        shotNum: json["shot_num"],
        shotPlace: json["shot_place"],
        status: statusValues.map![json["status"]],
        typeName: nextVaccineTypeValues.map![json["type_name"]],
      );

  Map<String, dynamic> toJson() => {
        "shot_date": shotDate.toString(),
        "shot_num": shotNum,
        "shot_place": shotPlace,
        "status": statusValues.reverse[status],
        "type_name": nextVaccineTypeValues.reverse[typeName],
      };
}

enum Status { NOT_TRUSTED, SHOTTED }

final statusValues =
    EnumValues({"not_trusted": Status.NOT_TRUSTED, "shotted": Status.SHOTTED});

enum NextVaccineType { ASTRA_ZENECA, NO_NEXT }

final nextVaccineTypeValues = EnumValues({
  "AstraZeneca": NextVaccineType.ASTRA_ZENECA,
  "NO_NEXT": NextVaccineType.NO_NEXT
});

class TypeOfPeople {
  TypeOfPeople({
    this.address,
    this.ageRange,
    this.dateOfShotExpect,
    this.nextVaccineType,
    this.priorityGroup,
  });

  Address? address;
  dynamic? ageRange;
  DateOfShotExpect? dateOfShotExpect;
  NextVaccineType? nextVaccineType;
  dynamic? priorityGroup;

  factory TypeOfPeople.fromRawJson(String str) =>
      TypeOfPeople.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TypeOfPeople.fromJson(Map<String, dynamic> json) => TypeOfPeople(
        address: Address.fromJson(json["address"]),
        ageRange: json["age_range"],
        dateOfShotExpect:
            DateOfShotExpect.fromJson(json["date_of_shot_expect"]),
        nextVaccineType: nextVaccineTypeValues.map![json["next_vaccine_type"]],
        priorityGroup: json["priority_group"],
      );

  Map<String, dynamic> toJson() => {
        "address": address!.toJson(),
        "age_range": ageRange,
        "date_of_shot_expect": dateOfShotExpect!.toJson(),
        "next_vaccine_type": nextVaccineTypeValues.reverse[nextVaccineType],
        "priority_group": priorityGroup,
      };
}

class DateOfShotExpect {
  DateOfShotExpect({
    this.endDate,
    this.startDate,
  });

  DateTime? endDate;
  DateTime? startDate;

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
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) => new MapEntry(v, k));
    return reverseMap!;
  }
}
