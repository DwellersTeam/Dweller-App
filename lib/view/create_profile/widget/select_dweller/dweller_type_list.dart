import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class DwellerTypeList extends StatefulWidget {
  const DwellerTypeList({super.key,});

  @override
  State<DwellerTypeList> createState() => _DwellerTypeListState();
}

class _DwellerTypeListState extends State<DwellerTypeList> {

  var controller = Get.put(CreateProfileController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated( 
      physics: const BouncingScrollPhysics(),
      itemCount: controller.dwellerTypeList.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(height: 30.h,);
      },
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
  
        return InkWell(
          onTap: () {
            setState(() {
              controller.selectedindex = index;
              print("selected index: ${controller.selectedindex}");
              controller.onDwellerTypeSelected(index: controller.selectedindex);
            });
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
            //height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(          
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                width: 2.0,
                color: controller.selectedindex == index ? AppColor.blueColor : AppColor.whiteColor
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.semiDarkGreyColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${controller.dwellerTypeList[index]['icon']}", 
                      style: GoogleFonts.poppins(
                        //color: AppColor.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    Text(
                      "${controller.dwellerTypeList[index]['type']}",
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),
                Text(
                  "${controller.dwellerTypeList[index]['description']}",
                  style: GoogleFonts.poppins(
                    color: AppColor.semiDarkGreyColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            )
          ),
        );
      }
    );
  }
}