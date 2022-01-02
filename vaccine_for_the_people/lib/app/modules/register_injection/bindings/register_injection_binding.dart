import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/data/services/viet_nam_repository.dart';

import '../controllers/register_injection_controller.dart';

class RegisterInjectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInjectionController>(() => RegisterInjectionController(
        vietNamRepository: VietNamRepository(vnProvider: VnProvider())));
  }
}
