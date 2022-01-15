import 'package:vaccine_for_the_people/app/data/models/injection_statistic.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_province.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_vaccine_distribution_province.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';

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

  Future<Province?> getDataInjectionStatisticFull(
      String province, String district, String wards) async{
    return await providerService.getDataInjectionStatisticFull(
        province, district, wards);
  }

  Future<Province?> getDataInjectionStatisticProvince(String province) async{
    return await providerService.getDataInjectionStatisticProvince(province);
  }

  Future<Province?> getDataInjectionStatisticProvinceAnDistrict(
      String province, String district) async{
    return await providerService.getDataInjectionStatisticProvinceAndDistrict(
        province, district);
  }

  Future<String?> login(String username, String password) async {
    return await providerService.login(username, password);
  }
}
