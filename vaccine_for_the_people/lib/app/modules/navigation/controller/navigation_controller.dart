import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/views/feedback_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/modules/login/views/login_view.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/views/register_injection_view.dart';
import 'package:vaccine_for_the_people/app/modules/search_feedback/views/search_feedback_view.dart';
import 'package:vaccine_for_the_people/app/modules/search_injection/view/search_injection_view.dart';

class NavigationController extends GetxController {
  final List<Widget> screens = [
    HomeScreen(),
    FeedbackView(),
    SearchFeedbackView(),
    SearchInjectionView(),
    RegisterInjectionView(),
    LoginView(),
  ].obs;
  final List<String> icons = const [
    "Trang Chủ",
    "Phản Hồi",
    "Tìm kiếm phản hồi",
    "Tra cứu tiêm chủng",
    "Đăng Kí Tiêm",
    "Đăng Nhập"
  ].obs;
  RxInt selectedIndex = 0.obs;
}
