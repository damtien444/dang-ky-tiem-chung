import 'package:get/get.dart';

import 'package:vaccine_for_the_people/app/modules/feedback/bindings/feedback_binding.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/views/feedback_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/binding/home_binding.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/modules/login/bindings/login_binding.dart';
import 'package:vaccine_for_the_people/app/modules/login/views/login_view.dart';
import 'package:vaccine_for_the_people/app/modules/navigation/view/navigation_view.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/bindings/register_injection_binding.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/views/register_injection_view.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOMESCREEN;

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
      name: Routes.NAVIGATION,
      page: () => NavigationScreen(),
    ),
  ];
}
