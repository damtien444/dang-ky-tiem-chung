import 'dart:convert';

VaccineDistribution vaccineDistributionFromJson(String str) => VaccineDistribution.fromJson(json.decode(str));

String vaccineDistributionToJson(VaccineDistribution data) => json.encode(data.toJson());

class VaccineDistribution {
  VaccineDistribution({
    required this.lastUpdated,
    required this.author,
    required this.portfolio,
    required this.totalDistribution,
    required this.dataDistribution,
    required this.dataVacDose,
  });

  String lastUpdated;
  String author;
  String portfolio;
  TotalDistribution totalDistribution;
  Map<String, DataDistribution> dataDistribution;
  Map<String, DataVacDose> dataVacDose;

  factory VaccineDistribution.fromJson(Map<String, dynamic> json) => VaccineDistribution(
    lastUpdated: json["lastUpdated"],
    author: json["author"],
    portfolio: json["portfolio"],
    totalDistribution: TotalDistribution.fromJson(json["totalDistribution"]),
    dataDistribution: Map.from(json["dataDistribution"]).map((k, v) => MapEntry<String, DataDistribution>(k, DataDistribution.fromJson(v))),
    dataVacDose: Map.from(json["dataVacDose"]).map((k, v) => MapEntry<String, DataVacDose>(k, DataVacDose.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "lastUpdated": lastUpdated,
    "author": author,
    "portfolio": portfolio,
    "totalDistribution": totalDistribution.toJson(),
    "dataDistribution": Map.from(dataDistribution).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "dataVacDose": Map.from(dataVacDose).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

class DataDistribution {
  DataDistribution({
    required this.name,
    required this.planned,
    required this.realistic,
    required this.distributedRate,
  });

  String name;
  int planned;
  int realistic;
  double distributedRate;

  factory DataDistribution.fromJson(Map<String, dynamic> json) => DataDistribution(
    name: json["name"],
    planned: json["Planned"],
    realistic: json["Realistic"],
    distributedRate: json["DistributedRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "Planned": planned,
    "Realistic": realistic,
    "DistributedRate": distributedRate,
  };
}

class DataVacDose {
  DataVacDose({
    required this.name,
    required this.vaccines,
    required this.onedose,
    required this.fulldose,
  });

  String name;
  int vaccines;
  int onedose;
  int fulldose;

  factory DataVacDose.fromJson(Map<String, dynamic> json) => DataVacDose(
    name: json["name"],
    vaccines: json["vaccines"],
    onedose: json["onedose"],
    fulldose: json["fulldose"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "vaccines": vaccines,
    "onedose": onedose,
    "fulldose": fulldose,
  };
}

class TotalDistribution {
  TotalDistribution({
    required this.totalPlanned,
    required this.totalRealistic,
    required this.totalDistributedRate,
  });

  int totalPlanned;
  int totalRealistic;
  double totalDistributedRate;

  factory TotalDistribution.fromJson(Map<String, dynamic> json) => TotalDistribution(
    totalPlanned: json["totalPlanned"],
    totalRealistic: json["totalRealistic"],
    totalDistributedRate: json["totalDistributedRate"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "totalPlanned": totalPlanned,
    "totalRealistic": totalRealistic,
    "totalDistributedRate": totalDistributedRate,
  };
}
