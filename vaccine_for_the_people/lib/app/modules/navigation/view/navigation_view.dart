import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';
import 'package:vaccine_for_the_people/app/modules/feedback/views/feedback_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/view/home_view.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/bottom_screen.dart';
import 'package:vaccine_for_the_people/app/modules/home/widgets/custome_app_bar.dart';
import 'package:vaccine_for_the_people/app/modules/login/views/login_view.dart';
import 'package:vaccine_for_the_people/app/modules/register_injection/views/register_injection_view.dart';
import 'package:vaccine_for_the_people/app/routes/app_routes.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    FeedbackView(),
    RegisterInjectionView(),
    LoginView(),
  ];
  final List<String> icons = const [
    "Trang Chủ",
    "Phản Hồi",
    "Đăng Kí Tiêm",
    "Đăng Nhập"
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
        child: DefaultTabController(
          length: 4,
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
                              height: 40,
                              width: 40,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: screenSize.width*0.25,
                              child: AutoSizeText(
                                'CỔNG THÔNG TIN TIÊM CHỦNG COVID-19',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 19,color: Colors.white),
                                minFontSize: 10,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: screenSize.width*0.25,),
                      Expanded(
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.yellow,
                          indicatorColor: Colors.transparent,
                          tabs:
                            icons.asMap().map((i, e) =>
                                MapEntry(i, Tab(
                                  child: Container(
                                    width: screenSize.width*0.07,
                                    child: AutoSizeText(
                                      '${e}',
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
                    ],
                  ),
                ),
              ),
            ),
            body: IndexedStack(
              index: _selectedIndex,
              children: _screens,
            ),
          ),
        )
    );
  }
}
