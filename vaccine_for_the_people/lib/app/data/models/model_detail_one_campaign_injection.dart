
import 'dart:convert';

DetailCampaignInjection detailCampaignInjectionFromJson(String str) => DetailCampaignInjection.fromJson(json.decode(str));

class DetailCampaignInjection {
  CurrentShotCampaign? currentShotCampaign;
  String? status;

  DetailCampaignInjection({this.currentShotCampaign, this.status});

  DetailCampaignInjection.fromJson(Map<String, dynamic> json) {
    currentShotCampaign = json['Current shot campaign'] != null
        ? CurrentShotCampaign.fromJson(json['Current shot campaign'])
        : null;
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentShotCampaign != null) {
      data['Current shot campaign'] = this.currentShotCampaign!.toJson();
    }
    data['Status'] = this.status;
    return data;
  }
}

class CurrentShotCampaign {
  String? sId;
  String? dateEnd;
  String? datePlace;
  String? dateStart;
  List<ListOfPeopleDetail>? listOfPeople;
  String? name;
  bool? status;
  TypeOfPeople? typeOfPeople;

  CurrentShotCampaign(
      {this.sId,
      this.dateEnd,
      this.datePlace,
      this.dateStart,
      this.listOfPeople,
      this.name,
      this.status,
      this.typeOfPeople});

  CurrentShotCampaign.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    dateEnd = json['date_end'];
    datePlace = json['date_place'];
    dateStart = json['date_start'];
    if (json['list_of_people'] != null) {
      listOfPeople = <ListOfPeopleDetail>[];
      json['list_of_people'].forEach((v) {
        listOfPeople!.add(new ListOfPeopleDetail.fromJson(v));
      });
    }
    name = json['name'];
    status = json['status'];
    typeOfPeople = json['type_of_people'] != null
        ? new TypeOfPeople.fromJson(json['type_of_people'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['date_end'] = this.dateEnd;
    data['date_place'] = this.datePlace;
    data['date_start'] = this.dateStart;
    if (this.listOfPeople != null) {
      data['list_of_people'] =
          this.listOfPeople!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['status'] = this.status;
    if (this.typeOfPeople != null) {
      data['type_of_people'] = this.typeOfPeople!.toJson();
    }
    return data;
  }
}

class ListOfPeopleDetail {
  String? sId;
  Address? address;
  double? age;
  bool? illnessHistory;
  LastShot? lastShot;
  String? name;
  String? nextExpectedShotDate;
  String? nextExpectedShotType;
  int? priorityGroup;
  bool? sex;
  // List<LastShot>? vaccineShots;

  ListOfPeopleDetail(
      {this.sId,
      this.address,
      this.age,
      this.illnessHistory,
      this.lastShot,
      this.name,
      this.nextExpectedShotDate,
      this.nextExpectedShotType,
      this.priorityGroup,
      this.sex,
      // this.vaccineShots
      });

  ListOfPeopleDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    age = json['age'];
    illnessHistory = json['illness_history'];
    lastShot = json['last_shot'] != null
        ? new LastShot.fromJson(json['last_shot'])
        : null;
    name = json['name'];
    nextExpectedShotDate = json['next_expected_shot_date'];
    nextExpectedShotType = json['next_expected_shot_type'];
    priorityGroup = json['priority_group'];
    sex = json['sex'];
    // if (json['vaccine_shots'] != null) {
    //   vaccineShots = <LastShot>[];
    //   json['vaccine_shots'].forEach((v) {
    //     vaccineShots!.add(LastShot.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['age'] = this.age;
    data['illness_history'] = this.illnessHistory;
    if (this.lastShot != null) {
      data['last_shot'] = this.lastShot!.toJson();
    }
    data['name'] = this.name;
    data['next_expected_shot_date'] = this.nextExpectedShotDate;
    data['next_expected_shot_type'] = this.nextExpectedShotType;
    data['priority_group'] = this.priorityGroup;
    data['sex'] = this.sex;
    // if (this.vaccineShots != null) {
    //   data['vaccine_shots'] =
    //       this.vaccineShots!.map((v) => v.toJson()).toList();
    // }
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
    data['district'] = district;
    data['province'] = province;
    data['st_no'] = stNo;
    data['ward'] = ward;
    return data;
  }
}

class LastShot {
  String? shotDate;
  int? shotNum;
  String? shotPlace;
  String? status;
  String? typeName;

  LastShot(
      {this.shotDate,
      this.shotNum,
      this.shotPlace,
      this.status,
      this.typeName});

  LastShot.fromJson(Map<String, dynamic> json) {
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

class TypeOfPeople {
  AddressCity? address;
  String? ageRange;
  DateOfShotExpect? dateOfShotExpect;
  String? nextVaccineType;
  int? priorityGroup;

  TypeOfPeople(
      {this.address,
      this.ageRange,
      this.dateOfShotExpect,
      this.nextVaccineType,
      this.priorityGroup});

  TypeOfPeople.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new AddressCity.fromJson(json['address']) : null;
    ageRange = json['age_range'];
    dateOfShotExpect = json['date_of_shot_expect'] != null
        ? new DateOfShotExpect.fromJson(json['date_of_shot_expect'])
        : null;
    nextVaccineType = json['next_vaccine_type'];
    priorityGroup = json['priority_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['age_range'] = this.ageRange;
    if (this.dateOfShotExpect != null) {
      data['date_of_shot_expect'] = this.dateOfShotExpect!.toJson();
    }
    data['next_vaccine_type'] = this.nextVaccineType;
    data['priority_group'] = this.priorityGroup;
    return data;
  }
}

class AddressCity {
  String? province;

  AddressCity({this.province});

  AddressCity.fromJson(Map<String, dynamic> json) {
    province = json['province'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province'] = this.province;
    return data;
  }
}

class DateOfShotExpect {
  String? endDate;
  String? startDate;

  DateOfShotExpect({this.endDate, this.startDate});

  DateOfShotExpect.fromJson(Map<String, dynamic> json) {
    endDate = json['end_date'];
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['end_date'] = this.endDate;
    data['start_date'] = this.startDate;
    return data;
  }
}
