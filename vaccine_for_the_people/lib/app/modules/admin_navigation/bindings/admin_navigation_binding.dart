import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/admin_navigation/controller/admin_navigation_controller.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/controller/injection_statistic_controller.dart';

class AdminNavigationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<AdminNavigationController>(() => AdminNavigationController());
     Get.put(InjectionStatisticController(repository: Repository(providerService: ProviderService())));
  }

}