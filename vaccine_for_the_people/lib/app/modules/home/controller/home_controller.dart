import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/models/map.dart';
import 'package:vaccine_for_the_people/app/data/models/vn_case_covid_seven_day.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomeController extends GetxController {
  Repository repository;

  HomeController({required this.repository});

  final RxInt totalCase = 0.obs;
  final RxInt totalDeath = 0.obs;
  final RxInt totalRecovered = 0.obs;
  final listCaseSevenDay = <CovidCaseSevenDay>[].obs;
  final dataRateVaccineDistribution = <Model>[].obs;
  final dataRateCaseCovid = <Model>[].obs;

  final mapSource = MapShapeSource.asset(
    'assets/vietnam3.json',
    shapeDataField: 'name',
  ).obs;
  final mapSource1 = MapShapeSource.asset(
    'assets/vietnam2.json',
    shapeDataField: 'name',
  ).obs;

  Future<void> getDataCovidCase() async {
    final dataVn= await Repository.getVNCase();
    totalCase.value=dataVn.cases;
    totalDeath.value = dataVn.deaths;
    totalRecovered.value = dataVn.recovered;
    // Repository.getVNCase().then((data) {
    //   totalCase.value = data.cases;
    //   totalDeath.value = data.deaths;
    //   totalRecovered.value = data.recovered;
    // });
  }

  Future<void> getDataCovidSevenDayCase() async {
    final data=await Repository.getVNCaseSevenDay();
    listCaseSevenDay.value=data;
    // Repository.getVNCaseSevenDay().then((data) {
    //   listCaseSevenDay.value = data;
    // });
  }

  Future<void> getDataVaccineRate() async {
    final data=await Repository.getVnVaccineDistribution();
      data.dataDistribution.map((key, value) => MapEntry(
          key,
          value.distributedRate < 50
              ? value.name == "Hồ Chí Minh"
                  ? dataRateVaccineDistribution
                      .add(Model("TP. Hồ Chí Minh", CustomeColor.rateVaccine1))
                  : value.name == "Đắk L��k"
                      ? dataRateVaccineDistribution
                          .add(Model("Đắk Lắk", CustomeColor.rateVaccine1))
                      : value.name == "Cao B���ng"
                          ? dataRateVaccineDistribution
                              .add(Model("Cao Bằng", CustomeColor.rateVaccine1))
                          : dataRateVaccineDistribution
                              .add(Model(value.name, CustomeColor.rateVaccine1))
              : value.distributedRate < 80
                  ? value.name == "Hồ Chí Minh"
                      ? dataRateVaccineDistribution.add(
                          Model("TP. Hồ Chí Minh", CustomeColor.rateVaccine2))
                      : value.name == "Đắk L��k"
                          ? dataRateVaccineDistribution
                              .add(Model("Đắk Lắk", CustomeColor.rateVaccine2))
                          : value.name == "Cao B���ng"
                              ? dataRateVaccineDistribution.add(
                                  Model("Cao Bằng", CustomeColor.rateVaccine2))
                              : dataRateVaccineDistribution.add(
                                  Model(value.name, CustomeColor.rateVaccine2))
                  : value.name == "Hồ Chí Minh"
                      ? dataRateVaccineDistribution.add(
                          Model("TP. Hồ Chí Minh", CustomeColor.rateVaccine3))
                      : value.name == "Đắk L��k"
                          ? dataRateVaccineDistribution
                              .add(Model("Đắk Lắk", CustomeColor.rateVaccine3))
                          : value.name == "Cao B���ng"
                              ? dataRateVaccineDistribution.add(
                                  Model("Cao Bằng", CustomeColor.rateVaccine3))
                              : dataRateVaccineDistribution.add(Model(
                                  value.name, CustomeColor.rateVaccine3))));
  }

  Future<void> getDataCaseCovidProvince() async {
    final data= await Repository.getVnCovidProvince();
      for (var value in data) {
        value.tongCaNhiem > 100000
            ? dataRateCaseCovid
                .add(Model(value.diaDiem, CustomeColor.rateCovid1))
            : (value.tongCaNhiem > 10000 && value.tongCaNhiem < 100000)
                ? dataRateCaseCovid
                    .add(Model(value.diaDiem, CustomeColor.rateCovid2))
                : (value.tongCaNhiem > 1000 && value.tongCaNhiem < 10000)
                    ? dataRateCaseCovid
                        .add(Model(value.diaDiem, CustomeColor.rateCovid3))
                    : dataRateCaseCovid
                        .add(Model(value.diaDiem, CustomeColor.rateCovid4));
      }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await getDataCovidSevenDayCase();
    await getDataCovidCase();
    await getDataCaseCovidProvince();
    await getDataVaccineRate();
  }
}
