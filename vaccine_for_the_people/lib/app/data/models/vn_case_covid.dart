// class VnCase {
//   late int updated;
//   late String country;
//   late CountryInfo countryInfo;
//   late int cases;
//   late int todayCases;
//   late int deaths;
//   late int todayDeaths;
//   late int recovered;
//   late int todayRecovered;
//   late int active;
//   late Null critical;
//
//   VnCase(
//       {required this.updated,
//         required this.country,
//         required this.countryInfo,
//         required this.cases,
//         required this.todayCases,
//         required this.deaths,
//         required this.todayDeaths,
//         required this.recovered,
//         required this.todayRecovered,
//         required this.active,
//         this.critical});
//
//   VnCase.fromJson(Map<String, dynamic> json) {
//     updated = json['updated'];
//     country = json['country'];
//     countryInfo = json['countryInfo'] != null
//         ? new CountryInfo.fromJson(json['countryInfo'])
//         : null;
//     cases = json['cases'];
//     todayCases = json['todayCases'];
//     deaths = json['deaths'];
//     todayDeaths = json['todayDeaths'];
//     recovered = json['recovered'];
//     todayRecovered = json['todayRecovered'];
//     active = json['active'];
//     critical = json['critical'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['updated'] = this.updated;
//     data['country'] = this.country;
//     if (this.countryInfo != null) {
//       data['countryInfo'] = this.countryInfo.toJson();
//     }
//     data['cases'] = this.cases;
//     data['todayCases'] = this.todayCases;
//     data['deaths'] = this.deaths;
//     data['todayDeaths'] = this.todayDeaths;
//     data['recovered'] = this.recovered;
//     data['todayRecovered'] = this.todayRecovered;
//     data['active'] = this.active;
//     data['critical'] = this.critical;
//     return data;
//   }
// }
//
// class CountryInfo {
//   late int iId;
//   late String iso2;
//   late String iso3;
//   late int lat;
//   late double long;
//
//   CountryInfo({required this.iId, required this.iso2, required this.iso3, required this.lat, required this.long});
//
//   CountryInfo.fromJson(Map<String, dynamic> json) {
//     iId = json['_id'];
//     iso2 = json['iso2'];
//     iso3 = json['iso3'];
//     lat = json['lat'];
//     long = json['long'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.iId;
//     data['iso2'] = this.iso2;
//     data['iso3'] = this.iso3;
//     data['lat'] = this.lat;
//     data['long'] = this.long;
//     return data;
//   }
// }
import 'dart:convert';

VnCase vnCaseFromJson(String str) => VnCase.fromJson(json.decode(str));

String vnCaseToJson(VnCase data) => json.encode(data.toJson());

class VnCase {
  VnCase({
    required this.updated,
    required this.country,
    required this.countryInfo,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.active,
    required this.critical,
  });

  int updated;
  String country;
  CountryInfo countryInfo;
  int cases;
  dynamic todayCases;
  int deaths;
  dynamic todayDeaths;
  int recovered;
  dynamic todayRecovered;
  int active;
  dynamic critical;

  factory VnCase.fromJson(Map<String, dynamic> json) => VnCase(
    updated: json["updated"],
    country: json["country"],
    countryInfo: CountryInfo.fromJson(json["countryInfo"]),
    cases: json["cases"],
    todayCases: json["todayCases"],
    deaths: json["deaths"],
    todayDeaths: json["todayDeaths"],
    recovered: json["recovered"],
    todayRecovered: json["todayRecovered"],
    active: json["active"],
    critical: json["critical"],
  );

  Map<String, dynamic> toJson() => {
    "updated": updated,
    "country": country,
    "countryInfo": countryInfo.toJson(),
    "cases": cases,
    "todayCases": todayCases,
    "deaths": deaths,
    "todayDeaths": todayDeaths,
    "recovered": recovered,
    "todayRecovered": todayRecovered,
    "active": active,
    "critical": critical,
  };
}

class CountryInfo {
  CountryInfo({
    required this.id,
    required this.iso2,
    required this.iso3,
    required this.lat,
    required this.long,
  });

  int id;
  String iso2;
  String iso3;
  int lat;
  double long;

  factory CountryInfo.fromJson(Map<String, dynamic> json) => CountryInfo(
    id: json["_id"],
    iso2: json["iso2"],
    iso3: json["iso3"],
    lat: json["lat"],
    long: json["long"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "iso2": iso2,
    "iso3": iso3,
    "lat": lat,
    "long": long,
  };
}
