import 'dart:convert';

ResponseSign responseSignFromJson(String str) =>
    ResponseSign.fromJson(json.decode(str));

String responseSignToJson(ResponseSign data) => json.encode(data.toJson());

class ResponseSign {
  ResponseSign({
    this.reason,
    required this.result,
  });

  String? reason;
  String result;

  factory ResponseSign.fromJson(Map<String, dynamic> json) => ResponseSign(
        reason: json["reason"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "reason": reason,
        "result": result,
      };
}
