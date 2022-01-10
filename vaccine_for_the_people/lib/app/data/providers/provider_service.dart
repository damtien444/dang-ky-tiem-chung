import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vaccine_for_the_people/app/data/models/injection_statistic.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_province.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_vaccine_distribution_province.dart';

class ProviderService {
  final token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI";
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
  Future<Province?> getDataInjectionStatisticFull(String province, String district, String wards) async {
    Map<String, String> requestHeader = {
      'x-access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI',
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
        Uri.parse('https://vaccine-for-the-people.herokuapp.com/campaign-statistic'),
        headers: requestHeader,
        body: body);
    if (httpPost.statusCode == 200) {
      final data = json.decode(json.encode(httpPost.body));
      final dataInjectionStatistic = provinceFromJson(data);
      print(dataInjectionStatistic);
      return dataInjectionStatistic;
    } else {

    }
  }
  Future<Province?> getDataInjectionStatisticProvince(String province) async {
    print(province);
    Map<String, String> requestHeader = {
      'x-access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI',
      'Content-Type': 'application/json; charset=utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"
    };
    final body = jsonEncode(
        {
          "address": {
            "province": province.toString()
          }
        }
    );
    var httpPost = await http.post(
        Uri.parse('https://vaccine-for-the-people.herokuapp.com/campaign-statistic'),
        headers: requestHeader,
        body: body);
    if (httpPost.statusCode == 200) {
      print(httpPost.body);
      final data = json.decode(json.encode(httpPost.body));
      final dataInjectionStatistic = provinceFromJson(data);
      print(dataInjectionStatistic.byArea?[1].sId);
      return dataInjectionStatistic;
    } else {

    }
  }
  Future<Province?> getDataInjectionStatisticProvinceAndDistrict(String province, String district) async {
    Map<String, String> requestHeader = {
      'x-access-token': 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJfaWQiOiI2MWM4NzlkYjBkYTNjNWE0MzNmODZmNzEiLCJleHAiOjE2NDE0OTMwMzV9.avThvdpgJzbu1MBGFewctRzN-2lKuBWy6WfSKK5wPmI',
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
        Uri.parse('https://vaccine-for-the-people.herokuapp.com/campaign-statistic'),
        headers: requestHeader,
        body: body);
    if (httpPost.statusCode == 200) {
      final data = json.decode(json.encode(httpPost.body));
      final dataInjectionStatistic = provinceFromJson(data);
      print(dataInjectionStatistic);
      return dataInjectionStatistic;
    } else {

    }
  }
}
