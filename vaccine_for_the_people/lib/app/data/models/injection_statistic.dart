// To parse this JSON data, do
//
//     final province = provinceFromJson(jsonString);

import 'dart:convert';

Province provinceFromJson(String str) => Province.fromJson(json.decode(str));

String provinceToJson(Province data) => json.encode(data.toJson());

class Province {
  List<ByAge>? byAge;
  List<ByAge>? byArea;
  List<ByAge>? byNextShotTime;
  List<ByAge>? byNextShotType;
  List<ByPriority>? byPriority;
  List<ByAge>? byProvince;
  List<BySex>? bySex;
  String? result;

  Province(
      {this.byAge,
        this.byArea,
        this.byNextShotTime,
        this.byNextShotType,
        this.byPriority,
        this.byProvince,
        this.bySex,
        this.result});

  Province.fromJson(Map<String, dynamic> json) {
    if (json['by_age'] != null) {
      byAge = <ByAge>[];
      json['by_age'].forEach((v) {
        byAge!.add(new ByAge.fromJson(v));
      });
    }
    if (json['by_area'] != null) {
      byArea = <ByAge>[];
      json['by_area'].forEach((v) {
        byArea!.add(ByAge.fromJson(v));
      });
    }
    if (json['by_next_shot_time'] != null) {
      byNextShotTime = <ByAge>[];
      json['by_next_shot_time'].forEach((v) {
        byNextShotTime!.add(ByAge.fromJson(v));
      });
    }
    if (json['by_next_shot_type'] != null) {
      byNextShotType = <ByAge>[];
      json['by_next_shot_type'].forEach((v) {
        byNextShotType!.add(ByAge.fromJson(v));
      });
    }
    if (json['by_priority'] != null) {
      byPriority = <ByPriority>[];
      json['by_priority'].forEach((v) {
        byPriority!.add(ByPriority.fromJson(v));
      });
    }
    if (json['by_province'] != null) {
      byProvince = <ByAge>[];
      json['by_province'].forEach((v) {
        byProvince!.add(ByAge.fromJson(v));
      });
    }
    if (json['by_sex'] != null) {
      bySex = <BySex>[];
      json['by_sex'].forEach((v) {
        bySex!.add(new BySex.fromJson(v));
      });
    }
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.byAge != null) {
      data['by_age'] = this.byAge!.map((v) => v.toJson()).toList();
    }
    if (this.byArea != null) {
      data['by_area'] = this.byArea!.map((v) => v.toJson()).toList();
    }
    if (this.byNextShotTime != null) {
      data['by_next_shot_time'] =
          this.byNextShotTime!.map((v) => v.toJson()).toList();
    }
    if (this.byNextShotType != null) {
      data['by_next_shot_type'] =
          this.byNextShotType!.map((v) => v.toJson()).toList();
    }
    if (this.byPriority != null) {
      data['by_priority'] = this.byPriority!.map((v) => v.toJson()).toList();
    }
    if (this.byProvince != null) {
      data['by_province'] = this.byProvince!.map((v) => v.toJson()).toList();
    }
    if (this.bySex != null) {
      data['by_sex'] = this.bySex!.map((v) => v.toJson()).toList();
    }
    data['result'] = this.result;
    return data;
  }
}

class ByAge {
  String? sId;
  int? count;

  ByAge({this.sId, this.count});

  ByAge.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['count'] = this.count;
    return data;
  }
}

class ByPriority {
  int? iId;
  int? count;

  ByPriority({this.iId, this.count});

  ByPriority.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['count'] = this.count;
    return data;
  }
}

class BySex {
  bool? bId;
  int? count;

  BySex({this.bId, this.count});

  BySex.fromJson(Map<String, dynamic> json) {
    bId = json['_id'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.bId;
    data['count'] = this.count;
    return data;
  }
}