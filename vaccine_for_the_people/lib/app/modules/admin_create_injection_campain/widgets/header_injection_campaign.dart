import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccine_for_the_people/app/core/values/custome_colors.dart';

class HeaderInjectionCampaign extends StatelessWidget {
  const HeaderInjectionCampaign({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Xác nhận tạo đợt tiêm chủng",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          Row(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 35,
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding:  const EdgeInsets.symmetric(vertical: 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)
                          ),
                          prefixIcon: const Icon(CupertinoIcons.search,size: 18,)
                      ) ,
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      
                    },
                    child: Container(
                      width: 80,
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: CustomeColor.colorAppBar
                      ),
                      child: Center(
                        child: Text("Tìm kiếm",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ),
                    ),
                  )

                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
