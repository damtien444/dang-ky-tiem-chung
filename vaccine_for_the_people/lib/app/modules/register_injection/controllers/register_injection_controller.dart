import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/my_dialog.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';

class RegisterInjectionController extends GetxController {
  VietNamRepository vietNamRepository;
  Repository repository;

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
    await vaccinationSign({
      "order_shot": 1,
      "name": "Minh",
      "birth_day": "2000-04-08",
      "sex": true,
      "phone": "0347813454",
      "email": "minh@gmail.com",
      "CCCD": "12423123456",
      "BHXH_id": "SV1233455666",
      "address": {
        "province": "Da Nang",
        "district": "Lien Chieu",
        "ward": "Hoa Khanh Bac",
        "st_no": "20 Nguyen Luong Bang"
      },
      "priority_group": 1,
      "illness_history": false,
      "expected_shot_date": "2021-06-20"
    });
  }

  Future<void> vaccinationSign(Map<String, dynamic> infoSign) async {
    try {
      final response = await repository.vaccinationSign(infoSign);
      if (response != null) {
        ready.value = true;
        // _showDialog();
        return;
      }
    } catch (e) {
      ready.value = true;
    //  _showDialog();
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

  void _showDialog() {
    Get.dialog(const MyDialog());
  }
}
