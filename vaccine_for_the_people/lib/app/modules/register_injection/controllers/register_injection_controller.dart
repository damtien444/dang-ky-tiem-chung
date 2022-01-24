import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/my_dialog.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';

class RegisterInjectionController extends GetxController {
  VietNamRepository vietNamRepository;
  Repository repository;
  GlobalKey<FormBuilderState> regInjectionFormKey =
      GlobalKey<FormBuilderState>();

  RegisterInjectionController(
      {required this.vietNamRepository, required this.repository});

  final isSecondInjection = false.obs;
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
  final init = ''.obs;
  final bool isEnable = false;
  final List<String> listAges = List.generate(99, (index) => '${++index}');
  final List<String> anamesis = ['Có', 'Không'];
  final List<String> typeObject = [
    '1. Nhân viên y tế ',
    '2. Người tham gia phòng chống dịch',
    '3. Lực lượng Quân đội',
    '4. Lực lượng Công an',
    '5. Nhân viên, cán bộ ngoại giao của Việt Nam',
    '6. Hải quan, cán bộ làm công tác xuất nhập cảnh',
    '7. Người cung cấp dịch vụ thiết yếu',
    '8. Giáo viên, người làm việc, học sinh, sinh viên',
    '9. Người mắc các bệnh mạn tính; Người trên 65 tuổi',
    '10. Người sinh sống tại các vùng có dịch',
    '11. Người nghèo, các đối tượng chính sách xã hội',
    '12. Người công tác, học tập, lao động ở nước ngoài',
    '13. Người lao động, thân nhân người lao động đang',
    '14. Các chức sắc, chức việc các tôn giáo',
    '15. Người lao động tự do',
    '16. Các đối tượng khác',
  ];
  final listVietNam = RxList<VietNam>();
  final listProvinces = RxList<String>();
  final listDistricts = RxList<String>();
  final listWards = RxList<String>();
  final initialTinh = 'Tất cả'.obs;
  final initialHuyen = 'Tất cả'.obs;
  final initialXa = 'Tất cả'.obs;
  final ready = true.obs;
  final orderShot = 0.obs;
  final name = ''.obs;
  final birthDay = ''.obs;
  final injectionDay = ''.obs;
  final phone = ''.obs;
  final email = ''.obs;
  final sex = ''.obs;
  final identificationCard = ''.obs;
  var priorityType = ''.obs;
  final province = ''.obs;
  final district = ''.obs;
  final ward = ''.obs;
  final stNo = ''.obs;
  final place = ''.obs;
  final injectionFirstDay = ''.obs;
  final typeFirstInjectionDay = ''.obs;
  final illnessHistory = ''.obs;

  final GlobalKey<FormFieldState> keyAnamesis = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keyOrderInjection =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keyPriorityGroup =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> keySex = GlobalKey<FormFieldState>();

  void resetData() {
    keyAnamesis.currentState!.reset();
    keyOrderInjection.currentState!.reset();
    keyPriorityGroup.currentState!.reset();
    keySex.currentState!.reset();
    phone.value = '';
    init.value = '';
    initialTinh.value = 'Tất cả';
    listDistricts.value = [];
    listWards.value = [];
    regInjectionFormKey.currentState!.reset();
  }

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

  Future<void> vaccinationSign(Map<String, dynamic> infoSign) async {
    try {
      ready.value = false;
      final response = await repository.vaccinationSign(infoSign);
      if (response?.result == 'success') {
        _showDialog(true);
        ready.value = true;
        return;
      }
    } catch (e) {
      ready.value = true;
      _showDialog(false);
    }
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

  void _showDialog(bool isSuccess) {
    Get.dialog(MyDialog(
      isSuccess: isSuccess,
      title: 'Đăng kí tiêm thành công, vui lòng kiểm tra email',
      failedTitle: 'Đăng kí tiêm thât bại, xin vui lòng thử lại',
      onDismissListen: () {},
    ));
  }
}
