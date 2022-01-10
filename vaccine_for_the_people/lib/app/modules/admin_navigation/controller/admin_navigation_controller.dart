import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/view/create_injection_campaign_view.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/view/injection_statistic_view.dart';
import 'package:vaccine_for_the_people/app/modules/statement_data/views/statement_data_view.dart';

class AdminNavigationController extends GetxController{
  final List<Widget> screens = [
    StatementDataView(),
    CreateInjectionCampaignView(),
    InjectionStatisticView(),
  ].obs;
  final List<String> title = const [
    "Trang Chủ",
    "Tạo đợt tiêm chủng",
    "Thống kê tiêm chủng",
  ].obs;
  RxInt selectedIndex = 0.obs;
}