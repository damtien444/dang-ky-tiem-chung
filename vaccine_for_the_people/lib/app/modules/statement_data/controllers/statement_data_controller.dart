import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/components/my_dialog.dart';
import 'package:vaccine_for_the_people/app/data/models/injection_registrant.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/models/viet_nam.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';

class StatementDataController extends GetxController {
  VietNamRepository vietNamRepository;
  Repository repository;

  StatementDataController(
      {required this.vietNamRepository, required this.repository});

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

  final List<String> listAges = List.generate(99, (index) => '${++index}');
  final List<String> anamesis = ['Có', 'Không'];
  final List<String> typeObject = [
    '1. Nhân viên y tế',
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
  final province = ''.obs;
  final district = ''.obs;
  final ward = ''.obs;
  final vaccineType = ''.obs;
  final startDate = ''.obs;
  final endDate = ''.obs;
  final place = ''.obs;
  var priorityType = -1.obs;
  var illnessHistory = -1.obs;
  var nameInjection = ''.obs;
  final isExpanded = false.obs;
  final RxMap dataFilter = {}.obs;
  Map<String, dynamic> injectInformation = {};
  final ready = true.obs;
  final listInjectors = RxList<ListElement>();

  Future<void> getProvinces() async {
    final data = await VietNamRepository.getProvinces();
    listVietNam.value = data;
    listProvinces.add("Tất cả");
    for (var element in listVietNam) {
      listProvinces.add(element.name!);
    }
  }

  Future<void> getListInjectionRegistrants(
      Map<dynamic, dynamic> dataFilter) async {
    try {
      ready.value = false;
      final response = await repository.getListInjectionRegistrants(dataFilter);
      if (response == null) {
        ready.value = true;
        return;
      }
      listInjectors.value = response.list;
      ready.value = true;
    } catch (e) {
      ready.value = true;
    }
  }

  void setDataFilter() {
    dataFilter.value = {
      "address": {
        "province": province.value.isEmpty || initialTinh.value == "Tất cả"
            ? null
            : province.value,
        "district": district.value.isEmpty || initialHuyen.value == "Tất cả"
            ? null
            : district.value,
        "ward": ward.value.isEmpty || initialXa.value == "Tất cả"
            ? null
            : ward.value,
      },
      "illness_history":
          illnessHistory == -1 ? null : (illnessHistory == 1 ? true : false),
      "priority_type": priorityType == -1 ? null : priorityType,
      "date_of_shot": {
        "start_date": startDate.value.isEmpty ? null : startDate.value,
        "end_date": endDate.value.isEmpty ? null : endDate.value,
      },
      "vaccine_type": vaccineType.value.isEmpty ? null : vaccineType.value,
    };
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getProvinces();
    setDataFilter();
    await getListInjectionRegistrants(dataFilter);
  }

  void _showDialog(bool isSuccess) {
    Get.dialog(MyDialog(
      isSuccess: isSuccess,
      title: 'Tạo đợt tiêm thành công',
      failedTitle: 'Tạo đợt tiêm thất bại, vui lòng kiểm tra lại',
      onDismissListen: () {},
    ));
  }

  Future<void> createCampaign() async {
    injectInformation = {
      "address": {
        "province": province.value.isEmpty ? null : province.value,
        "district": district.value.isEmpty || initialHuyen.value == "Tất cả"
            ? null
            : district.value,
        "ward": ward.value.isEmpty || initialXa.value == "Tất cả"
            ? null
            : ward.value,
        "st_no": null
      },
      "name": nameInjection.value.isEmpty ? null : nameInjection.value,
      "priority_type": priorityType == -1 ? null : priorityType,
      "date_of_shot": {
        "start_date": startDate.value.isEmpty ? null : startDate.value,
        "end_date": endDate.value.isEmpty ? null : endDate.value,
      },
      "vaccine_type": vaccineType.value.isEmpty ? null : vaccineType.value,
      "place": place.value.isEmpty ? null : place.value,
      "illness_history":
          illnessHistory == -1 ? null : (illnessHistory == 1 ? true : false),
    };
    try {
      final response = await repository.createCampaign(injectInformation);
      if (response?.result == 'success') {
        _showDialog(true);
        return;
      }
    } catch (e) {
      _showDialog(false);
    }
  }

  void findListDistricts(String data) {
    initialTinh.value = data;
    listDistricts.clear();
    initialHuyen.value = "Tất cả";
    if (initialTinh.value != "Tất cả") {
      listDistricts.add("Tất cả");
      listDistricts.addAll(listVietNam
          .firstWhere((element) => element.name == data)
          .districts!
          .map((e) => e.name!)
          .toList());
      initialHuyen.value = listDistricts.first;
    }
  }

  void findListWards(String data) {
    initialHuyen.value = data;
    listWards.clear();
    initialXa.value = "Tất cả";
    if (initialHuyen.value != "Tất cả") {
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
  }
}
