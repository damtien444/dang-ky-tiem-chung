import 'package:vaccine_for_the_people/app/data/models/injection_statistic.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_province.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_vaccine_distribution_province.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';

class Repository {
  ProviderService providerService;

  Repository({required this.providerService});

  static Future<VnCase> getVNCase() {
    return ProviderService.getVNCase();
  }

  static Future<List<CovidCaseSevenDay>> getVNCaseSevenDay() {
    return ProviderService.getVNCaseSevenDay();
  }

  static Future<VaccineDistribution> getVnVaccineDistribution() {
    return ProviderService.getVnVaccineDistribution();
  }

  static Future<List<VnCaseProvince>> getVnCovidProvince() {
    return ProviderService.getVnCovidProvince();
  }
  Future<Province?> getDataInjectionStatisticFull(String province,String district,String wards) {
    return providerService.getDataInjectionStatisticFull(province, district, wards);
  }
  Future<Province?> getDataInjectionStatisticProvince(String province) {
    return providerService.getDataInjectionStatisticProvince(province);
  }
  Future<Province?> getDataInjectionStatisticProvinceAnDistrict(String province,String district) {
    return providerService.getDataInjectionStatisticProvinceAndDistrict(province, district);
  }
}
