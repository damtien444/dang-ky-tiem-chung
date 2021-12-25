
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/home/binding/home_binding.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class AppPages{
  static const INITIAL = Routes.HOMESCREEN;

  static final routes = [
    GetPage(
      name: Routes.HOMESCREEN,
      page: () => HomeScreen(),
      binding:  HomeBinding(),
    ),

  ];
}