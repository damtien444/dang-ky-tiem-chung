import 'dart:convert';

import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_statistic.dart';
import 'package:vaccine_for_the_people/app/data/models/sale_data.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';

class InjectionStatisticController extends GetxController{
  Repository repository;
  InjectionStatisticController({required this.repository});
  final List<String> orderInjection = ['Mũi tiêm thứ nhất', 'Mũi tiêm thứ hai'];
  final List<String> genders = ['Nam', 'Nữ'];
  final List<String> listSession = ['Buổi sáng', 'Buổi chiều', 'Cả ngày'];
  final List<String> typeVaccine = [
    'AstraZeneca',
    'SPUTNIK V',
    'Vero Cell',
    'Moderna',
    'Pfizer',
    'Hayat-Vax',
    'Janssen',
    'Abdala'
  ];
  final bool isEnable = false;
  final List<String> listAges = List.generate(99, (index) => '${++index}');
  final List<String> anamesis = ['Có', 'Không'];
  final List<String> typeObject = [
    '1. Người làm việc trong các cơ sở y tế, ngành y tế (công lập và tư nhân)',
    '2. Người tham gia phòng chống dịch',
    '3. Lực lượng Quân đội',
    '4. Lực lượng Công an',
    '5. Nhân viên, cán bộ ngoại giao của Việt Nam và thân nhân được cử đi nước ngoài',
    '6. Hải quan, cán bộ làm công tác xuất nhập cảnh',
    '7. Người cung cấp dịch vụ thiết yếu: hàng không, vận tải, du lịch; cung cấp dịch vụ điện, nước',
    '8. Giáo viên, người làm việc, học sinh, sinh viên tại các cơ sở giáo dục, đào tạo',
    '9. Người mắc các bệnh mạn tính; Người trên 65 tuổi',
    '10. Người sinh sống tại các vùng có dịch',
    '11. Người nghèo, các đối tượng chính sách xã hội',
    '12. Người được cơ quan nhà nước có thẩm quyền cử đi công tác, học tập, lao động ở nước ngoài',
    '13. Các đối tượng là người lao động, thân nhân người lao động đang làm việc tại các doanh nghiệp',
    '14. Các chức sắc, chức việc các tôn giáo',
    '15. Người lao động tự do',
    '16. Các đối tượng khác',
  ];
  RxBool isLoading=false.obs;
  final listVietNam = RxList<VietNam>();
  final listProvinces = RxList<String>();
  final listDistricts = RxList<String>();
  final listWards = RxList<String>();

  final listDataAge=<ByAge>[].obs;
  final listDataArea=<ByAge>[].obs;
  final listDataByNextShotTime=<ByAge>[].obs;
  final listDataByNextShotType=<ByAge>[].obs;
  final listDataPriority=<ByPriority>[].obs;
  final listDataByProvince=<ByAge>[].obs;
  final listDataBySex=<BySex>[].obs;

  final listDataChartByAge=<SalesData>[].obs;
  final listDataChartByArea=<SalesData>[].obs;
  final listDataChartByNextShotType=<SalesData>[].obs;
  final listDataChartByAreaNextShotTime=<SalesData>[].obs;
  final listDataChartByPriority=<SalesData>[].obs;
  final listDataChartByGender=<SalesData>[].obs;

  final initialTinh = 'Tất cả'.obs;
  final initialHuyen = 'Tất cả'.obs;
  final initialXa = 'Tất cả'.obs;

  Future<void> getProvinces() async {
    final data = await VietNamRepository.getProvinces();
    listVietNam.value = data;
    listProvinces.add("Tất cả");
    for (var element in listVietNam) {
      listProvinces.add(element.name!);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getProvinces();
  }

  void findListDistricts(String data) {
    initialTinh.value = data;
    initialHuyen.value = "Tất cả";
    initialXa.value = "Tất cả";
    listDistricts.clear();
    listDistricts.add("Tất cả");
    listDistricts.addAll(listVietNam
        .firstWhere((element) => element.name == data)
        .districts!
        .map((e) => e.name!)
        .toList());
    initialHuyen.value = listDistricts.first;
  }

  void findListWards(String data) {
    initialHuyen.value = data;
    listWards.clear();
    listWards.add("Tất cả");
    listWards.addAll(
      listVietNam
          .firstWhere((province) => province.name == initialTinh.value)
          .districts!
          .firstWhere((district) => district.name == data)
          .wards!
          .map((e) => e.name!)
          .toList(),
    );
    initialXa.value = listWards.first;
  }

  Future<void> getDataSearchChartFull(String province,String district,String wards) async{
    final data = await repository.getDataInjectionStatisticFull(province, district, wards);
      listDataAge.value=data!.byAge!;
      listDataArea.value=data.byArea!;
      listDataByNextShotTime.value=data.byNextShotTime!;
      listDataByNextShotType.value=data.byNextShotType!;
      listDataPriority.value=data.byPriority!;
      listDataByProvince.value=data.byProvince!;
      listDataBySex.value=data.bySex!;
  }
  Future<void> getDataSearchChartProvince(String province) async{
    final data = await repository.getDataInjectionStatisticProvince(province);
      listDataAge.value=data!.byAge!;
      listDataArea.value=data.byArea!;
      listDataByNextShotTime.value=data.byNextShotTime!;
      listDataByNextShotType.value=data.byNextShotType!;
      listDataPriority.value=data.byPriority!;
      listDataByProvince.value=data.byProvince!;
      listDataBySex.value=data.bySex!;
  }
  Future<void> getDataSearchChartProvinceAndDistrict(String province,String district)async{
    final data = await repository.getDataInjectionStatisticProvinceAnDistrict(province, district);
      listDataAge.value=data!.byAge!;
      listDataArea.value=data.byArea!;
      listDataByNextShotTime.value=data.byNextShotTime!;
      listDataByNextShotType.value=data.byNextShotType!;
      listDataPriority.value=data.byPriority!;
      listDataByProvince.value=data.byProvince!;
      listDataBySex.value=data.bySex!;
  }
  String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }
  void fillDataChartProvince(){
    Future.delayed(const Duration(seconds: 4),() {
      for (var data in listDataAge) {
        listDataChartByAge.add(
            SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for (var data in listDataArea) {
        listDataChartByArea.add(
            SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for (var data in listDataByNextShotTime) {
        listDataChartByAreaNextShotTime.add(
            SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for (var data in listDataByNextShotType) {
        listDataChartByNextShotType.add(
            SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for (var data in listDataPriority) {
        listDataChartByPriority.add(
            SalesData(utf8convert(data.iId.toString()), data.count!));
      }
      for (var data in listDataBySex) {
        if (data.bId!) {
          listDataChartByGender.add(SalesData("Nam", data.count!));
        } else {
          listDataChartByGender.add(SalesData("Nữ", data.count!));
        }
      }
      isLoading.value=false;
    });
  }
  void fillDataChartProvinceAndDistrict(){
    Future.delayed(const Duration(seconds: 4),() {
      for(var data in listDataAge){
        listDataChartByAge.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataArea){
        listDataChartByArea.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataByNextShotTime){
        listDataChartByAreaNextShotTime.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataByNextShotType){
        listDataChartByNextShotType.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataPriority){
        listDataChartByPriority.add(SalesData(utf8convert(data.iId.toString()), data.count!));
      }
      for(var data in listDataBySex){
        if(data.bId!){
          listDataChartByGender.add(SalesData( "Nam", data.count!));
        }else{
          listDataChartByGender.add(SalesData( "Nữ", data.count!));
        }
      }
      isLoading.value=false;
    });
  }
  void fillDataChartAll(){
    Future.delayed(const Duration(seconds: 4),() {
      for(var data in listDataAge){
        listDataChartByAge.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataArea){
        listDataChartByArea.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataByNextShotTime){
        listDataChartByAreaNextShotTime.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataByNextShotType){
        listDataChartByNextShotType.add(SalesData(utf8convert(data.sId.toString()), data.count!));
      }
      for(var data in listDataPriority){
        listDataChartByPriority.add(SalesData(utf8convert(data.iId.toString()), data.count!));
      }
      for(var data in listDataBySex){
        if(data.bId!){
          listDataChartByGender.add(SalesData( "Nam", data.count!));
        }else{
          listDataChartByGender.add(SalesData( "Nữ", data.count!));
        }
      }
      isLoading.value=false;
    });
  }
}