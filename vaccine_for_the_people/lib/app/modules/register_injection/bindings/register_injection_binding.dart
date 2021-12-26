import 'package:get/get.dart';

import '../controllers/register_injection_controller.dart';

class RegisterInjectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInjectionController>(
      () => RegisterInjectionController(),
    );
  }
}
