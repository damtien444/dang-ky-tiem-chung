// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

class SearchResponse {
  SearchResponse({
     this.report,
     this.result,
  });

  Reports? report;
  String? result;

  factory SearchResponse.fromRawJson(String str) => SearchResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
    report: Reports.fromJson(json["report"]),
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "report": report!.toJson(),
    "result": result,
  };
}

class Reports {
  Reports({
     this.id,
     this.content,
     this.dateCreatedVn,
     this.email,
     this.hasResponse,
     this.name,
     this.response,
     this.status,
  });

  String? id;
  String? content;
  DateTime? dateCreatedVn;
  String? email;
  bool? hasResponse;
  String? name;
  String? response;
  String? status;

  factory Reports.fromRawJson(String str) => Reports.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
    id: json["_id"],
    content: json["content"],
    dateCreatedVn: DateTime.parse(json["date_created_vn"]),
    email: json["email"],
    hasResponse: json["has_response"],
    name: json["name"],
    response: json["response"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "date_created_vn": dateCreatedVn.toString(),
    "email": email,
    "has_response": hasResponse,
    "name": name,
    "response": response,
    "status": status,
  };
}
