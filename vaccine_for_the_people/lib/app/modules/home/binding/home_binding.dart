import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/vn_case_covid_provider.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/home/controller/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<HomeController>(() => HomeController(repository: Repository(vnCaseService: VnCaseService())));
  }
}