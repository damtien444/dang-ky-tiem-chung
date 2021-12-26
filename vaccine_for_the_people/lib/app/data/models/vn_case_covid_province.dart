
import 'dart:convert';

List<VnCaseProvince> vnCaseProvinceFromJson(String str) => List<VnCaseProvince>.from(json.decode(str).map((x) => VnCaseProvince.fromJson(x)));

String vnCaseProvinceToJson(List<VnCaseProvince> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VnCaseProvince {
  VnCaseProvince({
    required this.updatedAt,
    required this.diaDiem,
    required this.tongCaNhiem,
    required this.homNay,
    required this.tuVong,
  });

  int updatedAt;
  String diaDiem;
  int tongCaNhiem;
  int homNay;
  int tuVong;

  factory VnCaseProvince.fromJson(Map<String, dynamic> json) => VnCaseProvince(
    updatedAt: json["updatedAt"],
    diaDiem: json["dia_diem"],
    tongCaNhiem: json["tong_ca_nhiem"],
    homNay: json["hom_nay"],
    tuVong: json["tu_vong"],
  );

  Map<String, dynamic> toJson() => {
    "updatedAt": updatedAt,
    "dia_diem": diaDiem,
    "tong_ca_nhiem": tongCaNhiem,
    "hom_nay": homNay,
    "tu_vong": tuVong,
  };
}
