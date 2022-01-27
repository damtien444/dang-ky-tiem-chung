// To parse this JSON data, do
//
//     final report = reportFromJson(jsonString);

import 'dart:convert';

class Report {
  Report({
    required this.message,
    required this.reportId,
    required this.result,
  });

  String message;
  String reportId;
  String result;

  factory Report.fromRawJson(String str) => Report.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    message: json["message"],
    reportId: json["report_id"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "report_id": reportId,
    "result": result,
  };
}
