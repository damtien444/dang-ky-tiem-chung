import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/admin_navigation/controller/admin_navigation_controller.dart';

class AdminNavigationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdminNavigationController>(() => AdminNavigationController());
    
  }

}