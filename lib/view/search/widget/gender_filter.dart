import 'dart:developer';
import 'package:dweller/services/controller/search/searchpage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class FilterGenderList extends StatefulWidget {
  const FilterGenderList({super.key,});

  @override
  State<FilterGenderList> createState() => _FilterGenderListState();
}
class _FilterGenderListState extends State<FilterGenderList> {

  final searchPageController = Get.put(SearchPageController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 160.h,
      height: 50.h,
      child: ListView.separated(
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: searchPageController.genderList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 10.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {

              setState(() {
                if (searchPageController.selectedGenderList.contains(searchPageController.genderList[index])) {
                  searchPageController.selectedGenderList.remove(searchPageController.genderList[index]);
                  debugPrint("selected genders: ${searchPageController.selectedGenderList}");
                } 
                else {
                  searchPageController.selectedGenderList.add(searchPageController.genderList[index]);
                  debugPrint("selected genders: ${searchPageController.selectedGenderList}");
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              height: 40.h,
              //width: 90.w, //110.w
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: searchPageController.selectedGenderList.contains(searchPageController.genderList[index]) ? AppColor.blueColor : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: searchPageController.selectedGenderList.contains(searchPageController.genderList[index]) ? AppColor.blueColor: AppColor.greyColor
                )
              ),
              child: Text(
                searchPageController.genderList[index],  //${index}
                style: GoogleFonts.poppins(
                  color: searchPageController.selectedGenderList.contains(searchPageController.genderList[index]) ? AppColor.whiteColor : AppColor.neutralBlackColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400
                ),
              )
            ),
          );
        }
      ),
    );
  }
}