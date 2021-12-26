import 'dart:convert';

List<CovidCaseSevenDay> covidCaseSevenDayFromJson(String str) => List<CovidCaseSevenDay>.from(json.decode(str).map((x) => CovidCaseSevenDay.fromJson(x)));

String covidCaseSevenDayToJson(List<CovidCaseSevenDay> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CovidCaseSevenDay {
  CovidCaseSevenDay({
    required this.date,
    required this.death,
    required this.treating,
    required this.cases,
    required this.recovered,
    required this.avgCases7Day,
    required this.avgRecovered7Day,
    required this.avgDeath7Day,
  });

  String date;
  int death;
  int treating;
  int cases;
  int recovered;
  int avgCases7Day;
  int avgRecovered7Day;
  int avgDeath7Day;

  factory CovidCaseSevenDay.fromJson(Map<String, dynamic> json) => CovidCaseSevenDay(
    date: json["date"],
    death: json["death"],
    treating: json["treating"],
    cases: json["cases"],
    recovered: json["recovered"],
    avgCases7Day: json["avgCases7day"],
    avgRecovered7Day: json["avgRecovered7day"],
    avgDeath7Day: json["avgDeath7day"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "death": death,
    "treating": treating,
    "cases": cases,
    "recovered": recovered,
    "avgCases7day": avgCases7Day,
    "avgRecovered7day": avgRecovered7Day,
    "avgDeath7day": avgDeath7Day,
  };
}
