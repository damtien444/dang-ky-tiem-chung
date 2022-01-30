
import 'dart:convert';

SearchInjection searchInjectionFromJson(String str) => SearchInjection.fromJson(json.decode(str));
class SearchInjection {
  String? result;
  Person? person;

  SearchInjection({this.result, this.person});

  SearchInjection.fromJson(Map<String, dynamic> json) {
    result = json['Result'];
    person =
    json['person'] != null ? new Person.fromJson(json['person']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Result'] = this.result;
    if (this.person != null) {
      data['person'] = this.person!.toJson();
    }
    return data;
  }
}

class Person {
  String? bHXHId;
  String? cCCD;
  String? sId;
  Address? address;
  String? birthDay;
  bool? confirmEmail;
  bool? confirmOtp;
  String? email;
  bool? illnessHistory;
  String? name;
  String? nextExpectedShotDate;
  String? nextExpectedShotType;
  String? phone;
  int? priorityGroup;
  String? registerTime;
  bool? sex;
  String? userExpectedShotDate;
  List<VaccineShots>? vaccineShots;

  Person(
      {this.bHXHId,
        this.cCCD,
        this.sId,
        this.address,
        this.birthDay,
        this.confirmEmail,
        this.confirmOtp,
        this.email,
        this.illnessHistory,
        this.name,
        this.nextExpectedShotDate,
        this.nextExpectedShotType,
        this.phone,
        this.priorityGroup,
        this.registerTime,
        this.sex,
        this.userExpectedShotDate,
        this.vaccineShots});

  Person.fromJson(Map<String, dynamic> json) {
    bHXHId = json['BHXH_id'];
    cCCD = json['CCCD'];
    sId = json['_id'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    birthDay = json['birth_day'];
    confirmEmail = json['confirm_email'];
    confirmOtp = json['confirm_otp'];
    email = json['email'];
    illnessHistory = json['illness_history'];
    name = json['name'];
    nextExpectedShotDate = json['next_expected_shot_date'];
    nextExpectedShotType = json['next_expected_shot_type'];
    phone = json['phone'];
    priorityGroup = json['priority_group'];
    registerTime = json['register_time'];
    sex = json['sex'];
    userExpectedShotDate = json['user_expected_shot_date'];
    if (json['vaccine_shots'] != null) {
      vaccineShots = <VaccineShots>[];
      json['vaccine_shots'].forEach((v) {
        vaccineShots!.add(new VaccineShots.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BHXH_id'] = this.bHXHId;
    data['CCCD'] = this.cCCD;
    data['_id'] = this.sId;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['birth_day'] = this.birthDay;
    data['confirm_email'] = this.confirmEmail;
    data['confirm_otp'] = this.confirmOtp;
    data['email'] = this.email;
    data['illness_history'] = this.illnessHistory;
    data['name'] = this.name;
    data['next_expected_shot_date'] = this.nextExpectedShotDate;
    data['next_expected_shot_type'] = this.nextExpectedShotType;
    data['phone'] = this.phone;
    data['priority_group'] = this.priorityGroup;
    data['register_time'] = this.registerTime;
    data['sex'] = this.sex;
    data['user_expected_shot_date'] = this.userExpectedShotDate;
    if (this.vaccineShots != null) {
      data['vaccine_shots'] =
          this.vaccineShots!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  String? district;
  String? province;
  String? stNo;
  String? ward;

  Address({this.district, this.province, this.stNo, this.ward});

  Address.fromJson(Map<String, dynamic> json) {
    district = json['district'];
    province = json['province'];
    stNo = json['st_no'];
    ward = json['ward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district'] = this.district;
    data['province'] = this.province;
    data['st_no'] = this.stNo;
    data['ward'] = this.ward;
    return data;
  }
}

class VaccineShots {
  String? shotDate;
  int? shotNum;
  String? shotPlace;
  String? status;
  String? typeName;

  VaccineShots(
      {this.shotDate,
        this.shotNum,
        this.shotPlace,
        this.status,
        this.typeName});

  VaccineShots.fromJson(Map<String, dynamic> json) {
    shotDate = json['shot_date'];
    shotNum = json['shot_num'];
    shotPlace = json['shot_place'];
    status = json['status'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shot_date'] = this.shotDate;
    data['shot_num'] = this.shotNum;
    data['shot_place'] = this.shotPlace;
    data['status'] = this.status;
    data['type_name'] = this.typeName;
    return data;
  }
}