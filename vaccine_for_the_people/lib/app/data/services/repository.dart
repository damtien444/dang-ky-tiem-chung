import 'package:vaccine_for_the_people/app/data/models/create_campaign.dart';
import 'package:vaccine_for_the_people/app/data/models/feed_back_model.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_registrant.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_statistic.dart';
import 'package:vaccine_for_the_people/app/data/models/model_create_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/data/models/model_detail_one_campaign_injection.dart';
import 'package:vaccine_for_the_people/app/data/models/response_sign.dart';
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
      String province, String district, String wards) async {
    return await providerService.getDataInjectionStatisticFull(
        province, district, wards);
  }

  Future<Province?> getDataInjectionStatisticProvince(String province) async {
    return await providerService.getDataInjectionStatisticProvince(province);
  }

  Future<Province?> getDataInjectionStatisticProvinceAnDistrict(
      String province, String district) async {
    return await providerService.getDataInjectionStatisticProvinceAndDistrict(
        province, district);
  }

  static Future<CampaignInjection> getDataCampaignInjection() {
    return ProviderService.getDataCampaignInjection();
  }

  static Future<AllFeedback> getDataFeedback() {
    return ProviderService.getDataFeedback();
  }

  static Future<DetailCampaignInjection> getDetailOneDataCampaignInjection(String id) {
    return ProviderService.getDetailOneDataCampaignInjection(id);
  }

  static Future<bool> deletePeopleInCampaignInjection(String idCampaign,String idPeople) async {
    return ProviderService.deletePeopleInCampaignInjection(idCampaign, idPeople);
  }

  static Future<bool> deleteCampaignInjection(String idCampaign) async {
    return ProviderService.deleteCampaignInjection(idCampaign);
  }

  static Future<bool> deleteFeedback(String id) async {
    return ProviderService.deleteFeedback(id);
  }

  static Future<bool> promoteOneCampaignInjection(String id) async {
    return ProviderService.promoteOneCampaignInjection(id);
  }

  static Future<bool> updateCampaignInjection(String id,String name, String start,String end,String place) async {
    return ProviderService.updateCampaignInjection(id,name,start,end,place);
  }

  static Future<bool> replyFeedback(String id, String content)async{
    return ProviderService.replyFeedback(id, content);
  }

  Future<String?> login(String username, String password) async {
    return await providerService.login(username, password);
  }

  Future<InjectionRegistrant?> getListInjectionRegistrants(
      Map<dynamic, dynamic> dataFilter) async {
    return await providerService.getListInjectionRegistrants(dataFilter);
  }

  Future<ResponseSign?> vaccinationSign(Map<String, dynamic> infoSign) async {
    return await providerService.vaccinationSign(infoSign);
  }

  Future<CreateCampaign?> createCampaign(
      Map<String, dynamic> injectInformation) async {
    return await providerService.createCampaign(injectInformation);
  }
}
