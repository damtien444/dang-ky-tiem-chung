import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/binding/create_injection_campaign_binding.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/controller/create_injection_campaign_controller.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/view/create_injection_campaign_view.dart';
import 'package:vaccine_for_the_people/app/modules/admin_navigation/view/navigation_view.dart';

import 'package:vaccine_for_the_people/app/modules/admin_navigation/view/navigation_view.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/bindings/feedback_binding.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/views/feedback_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/binding/home_binding.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/modules/login/bindings/login_binding.dart';
import 'package:vaccine_for_the_people/app/modules/login/views/login_view.dart';
import 'package:vaccine_for_the_people/app/modules/navigation/view/navigation_view.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/bindings/register_injection_binding.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/views/register_injection_view.dart';
import 'package:vaccine_for_the_people/app/modules/statement_data/bindings/statement_data_binding.dart';
import 'package:vaccine_for_the_people/app/modules/statement_data/views/statement_data_view.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.NAVIGATIONADMIN;

  static final routes = [
    GetPage(
      name: Routes.HOMESCREEN,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.FEEDBACK,
      page: () => FeedbackView(),
      binding: FeedbackBinding(),
    ),
    GetPage(
      name: Routes.REGISTER_INJECTION,
      page: () => RegisterInjectionView(),
      binding: RegisterInjectionBinding(),
    ),
    GetPage(
      name: Routes.CREATEINJECTIONCAMPAIGN,
      page: () => CreateInjectionCampaignView(),
      binding: CreateInjectionCampaignBinding(),
    ),
    GetPage(
      name: Routes.NAVIGATION,
      page: () => NavigationScreen(),
    ),
    GetPage(
      name: Routes.NAVIGATIONADMIN,
      page: () => AdminNavigationScreen(),
    ),
    GetPage(
      name: Routes.STATEMENT_DATA,
      page: () => StatementDataView(),
      binding: StatementDataBinding(),
    ),
  ];
}
