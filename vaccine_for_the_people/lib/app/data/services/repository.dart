import 'package:vaccine_for_the_people/app/data/models/vn_case_covid.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_province.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_vaccine_distribution_province.dart';
import 'package:vaccine_for_the_people/app/data/providers/vn_case_covid_provider.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';

class Repository {
  VnCaseService vnCaseService;

  Repository({required this.vnCaseService});

  static Future<VnCase> getVNCase() {
    return VnCaseService.getVNCase();
  }

  static Future<List<CovidCaseSevenDay>> getVNCaseSevenDay() {
    return VnCaseService.getVNCaseSevenDay();
  }

  static Future<VaccineDistribution> getVnVaccineDistribution() {
    return VnCaseService.getVnVaccineDistribution();
  }

  static Future<List<VnCaseProvince>> getVnCovidProvince() {
    return VnCaseService.getVnCovidProvince();
  }
}
