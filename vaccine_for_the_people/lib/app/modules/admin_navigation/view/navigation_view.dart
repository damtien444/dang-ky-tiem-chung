import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/data/providers/vn_case_covid_provider.dart';
import 'package:vaccine_for_the_people/app/data/services/repository.dart';
import 'package:vaccine_for_the_people/app/modules/admin_create_injection_campain/view/create_injection_campaign_view.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/controllers/feedback_controller.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/views/feedback_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/controller/home_controller.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/custome_app_bar.dart';
import 'package:vaccine_for_the_people/app/modules/injection_statistic/view/injection_statistic_view.dart';
import 'package:vaccine_for_the_people/app/modules/login/controllers/login_controller.dart';
import 'package:vaccine_for_the_people/app/modules/login/views/login_view.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/controllers/register_injection_controller.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/views/register_injection_view.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class AdminNavigationScreen extends StatefulWidget {
  const AdminNavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<AdminNavigationScreen> {
  final List<Widget> _screens = [
    // HomeScreen(),
    // FeedbackView(),
    // RegisterInjectionView(),
    // LoginView(),
    Scaffold(),
    CreateInjectionCampaignView(),
    InjectionStatisticView(),
  ];
  final List<String> title = const [
    "Trang Chủ",
    "Tạo đợt tiêm chủng",
    "Thống kê tiêm chủng",
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar:PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [
                          0.1,
                          0.4,
                        ],
                        colors: <Color>[
                          CustomeColor.colorAppBarStart,
                          CustomeColor.colorAppBar
                        ])
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 100),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icon_heart.png",
                              fit: BoxFit.contain,
                              height: 50,
                              width: 50,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: screenSize.width*0.25,
                              child: AutoSizeText(
                                'CỔNG THÔNG TIN TIÊM CHỦNG COVID-19',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
                                minFontSize: 10,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width*0.19,),
                      Expanded(
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.yellow,
                          indicatorColor: Colors.transparent,
                          tabs:
                          title.asMap().map((i, e) =>
                                MapEntry(i, Tab(
                                  child: Container(
                                    width: screenSize.width*0.1,
                                    child: AutoSizeText(
                                      e,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                      minFontSize: 10,
                                    ),
                                  ),
                                ),
                            ))
                                .values
                                .toList(),
                          onTap: (index){
                            setState(() {
                              _selectedIndex=index;
                            });
                          }
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (context){
                                return Dialog(
                                  child: Container(
                                    width: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(height: 10,),
                                          Center(
                                            child: Image.asset(
                                              "assets/images/icon_heart.png",
                                              fit: BoxFit.contain,
                                              height: 70,
                                              width: 70,
                                              color: CustomeColor.colorAppBar,
                                            ),
                                          ),
                                          const SizedBox(height: 15,),
                                          Text("Bạn chắc chắn muốn đăng xuất ?",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,fontFamily: "impact"),),
                                          const SizedBox(height: 15,),
                                          Text("Nếu bạn đăng xuất, quyền admin hiện tại sẽ không còn hiệu lực, bạn phải thực hiện đăng nhập lại để có thể thực hiện các thao tác của nhà quản lí !!!",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.grey,fontFamily: "impact"),),
                                          const SizedBox(height: 15,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width:120,
                                                height: 35,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary: CustomeColor.colorAppBar, //background color of button
                                                    // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                                                    shape: RoundedRectangleBorder( //to set border radius to button
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  child: Text("Đăng xuất",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal,fontFamily: "impact")),
                                                  onPressed: () async{
                                                    Get.offAndToNamed(Routes.NAVIGATION);
                                                    Get.put(RegisterInjectionController());
                                                    Get.put(LoginController());
                                                    Get.put(FeedbackController());
                                                    Get.put(HomeController(repository: Repository(vnCaseService: VnCaseService())));
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 30,),
                                              SizedBox(
                                                width:120,
                                                height: 35,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Colors.red, //background color of button
                                                    // side: const BorderSide(width:1, color:Colors.grey), //border width and color//elevation of button
                                                    shape: RoundedRectangleBorder( //to set border radius to button
                                                        borderRadius: BorderRadius.circular(10)
                                                    ),
                                                  ),
                                                  child: Text("Hủy bỏ",style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "impact",fontWeight: FontWeight.normal)),
                                                  onPressed: () async{
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                          );
                        },
                        child: SizedBox(
                          width: screenSize.width*0.07,
                          child: AutoSizeText(
                            'Đăng xuất',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 15,color: Colors.white),
                            minFontSize: 10,
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            )
          ),
        )
    );
  }
}
