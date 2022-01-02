import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/services/viet_nam_repository.dart';

class RegisterInjectionController extends GetxController {
  VietNamRepository vietNamRepository;

  RegisterInjectionController({required this.vietNamRepository});

  GlobalKey<FormBuilderState> regInjectionFormKey =
      GlobalKey<FormBuilderState>();
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
  final listVietNam = RxList<VietNam>();
  final listProvinces = RxList<String>();
  final listDistricts = RxList<String>();
  final listWards = RxList<String>();
  final isDropDownDistrict = false.obs;
  final isDropDownWard = false.obs;

  Future<void> getProvinces() async {
    final data = await VietNamRepository.getProvinces();
    listVietNam.value = data;
    listProvinces.add("Tất cả");
    listDistricts.add("Tất cả");
    listWards.add("Tất cả");
    for (var element in listVietNam) {
      listProvinces.add(element.name!);
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getProvinces();
  }

  void onSelectionAddress(dynamic _) {
    regInjectionFormKey.currentState?.save();
    if (regInjectionFormKey.currentState!.value['province'] != null ||
        regInjectionFormKey.currentState!.value['province'].toString() !=
            'Tất cả') {
      isDropDownDistrict.value = true;
      isDropDownWard.value = false;

      findListDistricts();
    }
    if (regInjectionFormKey.currentState!.value['district'] != null ||
        regInjectionFormKey.currentState!.value['district'].toString() !=
            'Tất cả') {
      isDropDownWard.value = true;
      findListWards();
    }
  }

  void findListDistricts() {
    listDistricts.clear();
    listDistricts.add("Tất cả");
    listDistricts.addAll(
      listVietNam
          .firstWhere((element) =>
              element.name ==
              regInjectionFormKey.currentState!.value['province'])
          .districts!
          .map((e) => e.name!)
          .toList(),
    );
  }

  void findListWards() {
    listWards.clear();
    listWards.add("Tất cả");
    listWards.addAll(
      listVietNam
          .firstWhere((province) =>
              province.name ==
              regInjectionFormKey.currentState!.value['province'])
          .districts!
          .firstWhere((ward) =>
              ward.name == regInjectionFormKey.currentState!.value['district'])
          .wards!
          .map((e) => e.name!)
          .toList(),
    );
  }
}
