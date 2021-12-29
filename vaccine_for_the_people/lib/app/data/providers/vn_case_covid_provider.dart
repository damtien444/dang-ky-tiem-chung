import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_province.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_vaccine_distribution_province.dart';

class VnCaseService{

  static Future<VnCase> getVNCase() async{
    final baseUrl="https://api.ncovvn.xyz/wom/countries/vietnam/";
    final url=Uri.parse(baseUrl);
    final respone=await http.get(url);
    if(respone.statusCode==200){
      // final result=JsonDecoder(respone.body);
      final VnCase vnCase=vnCaseFromJson(respone.body);
      // print(vnCase.updated);
      return vnCase;
    }
    else{
      return throw("error");
    }
  }

  static Future<List<CovidCaseSevenDay>> getVNCaseSevenDay() async{
    final baseUrl="https://api.ncovvn.xyz/lastsevenday";
    final url=Uri.parse(baseUrl);
    final respone=await http.get(url);
    if(respone.statusCode==200){
      // final result=JsonDecoder(respone.body);
      final List<CovidCaseSevenDay> vnCaseSevenDay=covidCaseSevenDayFromJson(respone.body);
      // print(vnCase.updated);
      return vnCaseSevenDay;
    }
    else{
      return throw("error");
    }
  }

  static Future<VaccineDistribution> getVnVaccineDistribution() async{
    final baseUrl="https://api-kent.netlify.app/.netlify/functions/api/vn/vaccines/distribution";
    final url=Uri.parse(baseUrl);
    final respone=await http.get(url);
    if(respone.statusCode==200){
      // String body = utf8.decode(respone.bodyBytes);
      final data=vaccineDistributionFromJson(respone.body);
      // for(int i=0;i<data.dataDistribution.length;i++){
      //   print(data.dataDistribution[i]!.name);
      // }
      return data;
    }
    else{
      return throw("error");
    }
  }

  static Future<List<VnCaseProvince>> getVnCovidProvince() async{
    final baseUrl="https://api.ncovvn.xyz/cityvn/";
    final url=Uri.parse(baseUrl);
    final respone=await http.get(url);
    if(respone.statusCode==200){
      final vnCovidProvince= vnCaseProvinceFromJson(respone.body);
      return vnCovidProvince;
    }
    else{
      return throw("error");
    }
  }
}