import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/data/providers/provider_service.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/home/controller/home_controller.dart';
import 'package:vaccine_for_the_people/app/modules/login/controllers/login_controller.dart';
import 'package:vaccine_for_the_people/app/modules/navigation/controller/navigation_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';
import 'package:vaccine_for_the_people/app/data/providers/viet_nam_provider.dart';
import 'package:vaccine_for_the_people/app/data/services/viet_nam_repository.dart';

class NavigationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.put<HomeController>(HomeController(repository: Repository(providerService: ProviderService())));
    Get.put(RegisterInjectionController(
        vietNamRepository: VietNamRepository(vnProvider: VnProvider())));
    Get.put(LoginController());
    Get.put(FeedbackController());
  }

}