import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';
import 'package:vaccine_for_the_people/app/modules/admin_navigation/controller/admin_navigation_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';

class AdminNavigationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdminNavigationController>(() => AdminNavigationController());
    Get.lazyPut<RegisterInjectionController>(
          () => RegisterInjectionController(
        vietNamRepository: VietNamRepository(vnProvider: VnProvider()),
      ),
    );
  }

}