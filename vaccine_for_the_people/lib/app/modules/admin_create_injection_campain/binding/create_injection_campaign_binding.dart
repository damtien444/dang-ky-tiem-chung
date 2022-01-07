import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';

class CreateInjectionCampaignBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<CreateInjectionCampaignController>(() => CreateInjectionCampaignController());
  }

}