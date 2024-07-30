import 'package:dweller/model/listing/property_model.dart';
import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/home/widget/profile(h&s)/profile_info.dart';
import 'package:dweller/view/home/widget/property/host_property_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';










class HostTabPage extends StatefulWidget {
  const HostTabPage({super.key, required this.property,});
  //final UserModel user;
  final PropertyHostModel property;

  @override
  State<HostTabPage> createState() => _HostTabPageState();
}

class _HostTabPageState extends State<HostTabPage> with SingleTickerProviderStateMixin {
  
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h,),
            ///HEADER///
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset("assets/svg/arrow_back.svg")
                  ),
                  SizedBox(width: 15.w,),
                  Text(
                    "Back",
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30.h),
            
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 70.w), //50.w
                    child: AnimatedContainer(
                      //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
                      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.blueColorOp,
                        borderRadius: BorderRadius.circular(50.r),
                        border: Border.all(color: AppColor.blueColorOp)
                      ),
                      duration: const Duration(milliseconds: 100),
                      child: Column(
                        children: [
                          //added
                          TabBar(                    
                            physics: const BouncingScrollPhysics(),
                            indicatorPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h), //3.w, 3.h
                            indicatorColor: AppColor.blackColor,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: AppColor.whiteColor,
                            //indicatorWeight: 0.1,
                            labelStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            unselectedLabelColor: AppColor.blackColor,
                            labelColor: AppColor.whiteColor,
                            //padding: EdgeInsets.symmetric(horizontal: 10),
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.r),
                              color: AppColor.blackColor,
                              shape: BoxShape.rectangle,
                            ),
                            controller: tabController,
                            isScrollable: false,
                            tabs: const [
                              Tab(text: 'Profile',),
                              Tab(text: 'Property',),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  SizedBox(height:20.h),
                    
                  //tabbar content here //wrap with future builder
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ProfileInfo(user: widget.property.propertyOwner),
                        HostPropertyInfo(model: widget.property,),
                      ]
                    ),
                  ),
                  //SizedBox(height:40.h),
                ]
              )
            )
            //
          
          ],
        ),
      )
    );
  }
}