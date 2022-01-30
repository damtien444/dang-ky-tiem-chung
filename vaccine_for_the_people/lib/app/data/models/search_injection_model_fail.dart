import 'dart:convert';

SearchInjectionFail searchInjectionFailFromJson(String str) => SearchInjectionFail.fromJson(json.decode(str));

String searchInjectionFailToJson(SearchInjectionFail data) => json.encode(data.toJson());

class SearchInjectionFail {
  SearchInjectionFail({
    this.result,
    this.message,
  });

  String ?result;
  String ?message;

  factory SearchInjectionFail.fromJson(Map<String, dynamic> json) => SearchInjectionFail(
    result: json["Result"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "Result": result,
    "message": message,
  };
}
