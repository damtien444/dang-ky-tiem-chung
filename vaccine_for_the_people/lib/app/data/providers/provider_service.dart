import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz_streaming.dart';
import 'package:http/http.dart' as http;
import 'package:vaccine_for_the_people/app/data/models/create_campaign.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_registrant.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_statistic.dart';
import 'package:vaccine_for_the_people/app/data/models/model_create_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/data/models/model_detail_one_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/data/models/report.dart';
import 'package:vaccine_for_the_people/app/data/models/response_sign.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_province.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_vaccine_distribution_province.dart';

class ProviderService {
  final token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI";

  static Future<VnCase> getVNCase() async {
    const baseUrl = "https://api.ncovvn.xyz/wom/countries/vietnam/";
    final url = Uri.parse(baseUrl);
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      // final result=JsonDecoder(respone.body);
      final VnCase vnCase = vnCaseFromJson(respone.body);
      // print(vnCase.updated);
      return vnCase;
    } else {
      return throw ("error");
    }
  }

  static Future<List<CovidCaseSevenDay>> getVNCaseSevenDay() async {
    const baseUrl = "https://api.ncovvn.xyz/lastsevenday";
    final url = Uri.parse(baseUrl);
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      // final result=JsonDecoder(respone.body);
      final List<CovidCaseSevenDay> vnCaseSevenDay =
          covidCaseSevenDayFromJson(respone.body);
      // print(vnCase.updated);
      return vnCaseSevenDay;
    } else {
      return throw ("error");
    }
  }

  static Future<VaccineDistribution> getVnVaccineDistribution() async {
    const baseUrl =
        "https://api-kent.netlify.app/.netlify/functions/api/vn/vaccines/distribution";
    final url = Uri.parse(baseUrl);
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      // String body = utf8.decode(respone.bodyBytes);
      final data = vaccineDistributionFromJson(respone.body);
      // for(int i=0;i<data.dataDistribution.length;i++){
      //   print(data.dataDistribution[i]!.name);
      // }
      return data;
    } else {
      return throw ("error");
    }
  }

  static Future<List<VnCaseProvince>> getVnCovidProvince() async {
    const baseUrl = "https://api.ncovvn.xyz/cityvn/";
    final url = Uri.parse(baseUrl);
    final respone = await http.get(url);
    if (respone.statusCode == 200) {
      final vnCovidProvince = vnCaseProvinceFromJson(respone.body);
      return vnCovidProvince;
    } else {
      return throw ("error");
    }
  }

  Future<Province?> getDataInjectionStatisticFull(
      String province, String district, String wards) async {
    Map<String, String> requestHeader = {
      'x-access-token':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI',
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    };
    final body = jsonEncode({
      "address": {
        "province": province.toString(),
        "district": district.toString(),
        "wards": wards.toString()
      }
    });
    var httpPost = await http.post(
        Uri.parse(
            'https://vaccine-for-the-people.herokuapp.com/campaign-statistic'),
        headers: requestHeader,
        body: body);
    if (httpPost.statusCode == 200) {
      final data = json.decode(json.encode(httpPost.body));
      final dataInjectionStatistic = provinceFromJson(data);
      print(dataInjectionStatistic);
      return dataInjectionStatistic;
    } else {}
  }

  Future<Province?> getDataInjectionStatisticProvince(String province) async {
    print(province);
    Map<String, String> requestHeader = {
      'x-access-token':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI',
      'Content-Type': 'application/json; charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    };
    final body = jsonEncode({
      "address": {"province": province.toString()}
    });
    var httpPost = await http.post(
        Uri.parse(
            'https://vaccine-for-the-people.herokuapp.com/campaign-statistic'),
        headers: requestHeader,
        body: body);
    if (httpPost.statusCode == 200) {
      final data = json.decode(json.encode(httpPost.body));
      final dataInjectionStatistic = provinceFromJson(data);
      return dataInjectionStatistic;
    } else {}
  }

  Future<Province?> getDataInjectionStatisticProvinceAndDistrict(
      String province, String district) async {
    Map<String, String> requestHeader = {
      'x-access-token':
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI',
      'Content-Type': 'application/json',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    };
    final body = jsonEncode({
      "address": {
        "province": province.toString(),
        "district": district.toString()
      }
    });
    var httpPost = await http.post(
        Uri.parse(
            'https://vaccine-for-the-people.herokuapp.com/campaign-statistic'),
        headers: requestHeader,
        body: body);
    if (httpPost.statusCode == 200) {
      final data = json.decode(json.encode(httpPost.body));
      final dataInjectionStatistic = provinceFromJson(data);
      print(dataInjectionStatistic);
      return dataInjectionStatistic;
    } else {}
  }

  static Future<CampaignInjection> getDataCampaignInjection() async {
    const baseUrl = "https://vaccine-for-the-people.herokuapp.com/campaign";
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = campaignInjectionFromJson(response.body);
      return data;
    } else {
      return throw ("error");
    }
  }

  static Future<DetailCampaignInjection> getDetailOneDataCampaignInjection(
      String id) async {
    final baseUrl =
        "https://vaccine-for-the-people.herokuapp.com/campaign/${id.toString()}";
    final url = Uri.parse(baseUrl);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = detailCampaignInjectionFromJson(response.body);
      return data;
    } else {
      return throw ("error");
    }
  }

  static Future<bool> deletePeopleInCampaignInjection(
      String idCampaign, String idPeople) async {
    print("idcampaign: " + idCampaign + " id people" + idPeople);
    final baseUrl =
        "https://vaccine-for-the-people.herokuapp.com/campaign/${idCampaign.toString()}/user/${idPeople.toString()}";
    final url = Uri.parse(baseUrl);
    final response = await http.delete(url);
    print("status code la: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("xoa thanh cong");
      return true;
    } else {
      print("xoa that bai");
      return false;
    }
  }

  static Future<bool> deleteCampaignInjection(String idCampaign) async {
    final baseUrl =
        "https://vaccine-for-the-people.herokuapp.com/campaign/${idCampaign.toString()}";
    final url = Uri.parse(baseUrl);
    final response = await http.delete(url);
    print("status code la: " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("xoa thanh cong");
      return true;
    } else {
      print("xoa that bai");
      return false;
    }
  }

  static Future<bool> promoteOneCampaignInjection(String id) async {
    Map<String, String> requestHeader = {'Content-Type': 'application/json'};
    print("id: " + id.toString());
    final body = jsonEncode({"update_type": "promote"});
    final httpUrl =
        "https://vaccine-for-the-people.herokuapp.com/campaign/${id.toString()}";
    var httpPost = await http.put(
      Uri.parse(httpUrl),
      body: body,
      headers: requestHeader,
      encoding: Encoding.getByName("utf-8"),
    );
    print("status code: " + httpPost.statusCode.toString());
    if (httpPost.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static Future<bool> updateCampaignInjection(
      String id, String name, String start, String end, String place) async {
    print(id + " " + name + " " + place);
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json;charset=utf-8',
    };
    print("id: " + id.toString());
    final body = jsonEncode({
      "update_type": "update",
      "name": name.toString(),
      "date_start": start.toString(),
      "date_end": end.toString(),
      "place": place.toString()
    });
    final httpUrl =
        "https://vaccine-for-the-people.herokuapp.com/campaign/${id.toString()}";
    var httpPost = await http.put(
      Uri.parse(httpUrl),
      body: body,
      headers: requestHeader,
      encoding: Encoding.getByName("utf-8"),
    );
    print("status code: " + httpPost.statusCode.toString());
    if (httpPost.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String?> login(
    String username,
    String password,
  ) async {
    try {
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final response = await http.get(
        Uri.parse('https://vaccine-for-the-people.herokuapp.com/login'),
        headers: <String, String>{'authorization': basicAuth},
      );
      if (response.statusCode == 200) {
        final token = response.body;
        return token;
      }
      return '';
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseSign?> vaccinationSign(Map<String, dynamic> infoSign) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      };
      final body = jsonEncode(infoSign);
      final response = await http.post(
          Uri.parse(
              'https://vaccine-for-the-people.herokuapp.com/vaccination-sign'),
          headers: requestHeader,
          body: body);
      if (response.statusCode == 200) {
        final result = responseSignFromJson(response.body);
        return result;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<Report?> report(Map<String, dynamic> infoUser) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      };
      final body = jsonEncode(infoUser);
      final response = await http.post(
          Uri.parse(
              'https://vaccine-for-the-people.herokuapp.com/report-public'),
          headers: requestHeader,
          body: body);
      if (response.statusCode == 200) {
        final result = Report.fromRawJson(response.body);
        return result;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateCampaign?> createCampaign(
      Map<String, dynamic> injectInformation) async {
    try {
      Map<String, String> requestHeader = {
        'Content-Type': 'application/json',
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
      };
      final body = jsonEncode(injectInformation);
      final response = await http.post(
          Uri.parse('https://vaccine-for-the-people.herokuapp.com/campaign'),
          headers: requestHeader,
          body: body);
      if (response.statusCode == 200) {
        final result = CreateCampaign.fromRawJson(response.body);
        return result;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  Future<InjectionRegistrant?> getListInjectionRegistrants(
    Map<dynamic, dynamic> dataFilter,
  ) async {
    try {
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      final response = await http.post(
          Uri.parse(
              'https://vaccine-for-the-people.herokuapp.com/campaign-preview'),
          headers: headers,
          body: jsonEncode(dataFilter));
      if (response.statusCode == 200) {
        final data =
            InjectionRegistrant.fromRawJson(utf8.decode(response.bodyBytes));
        return data;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
