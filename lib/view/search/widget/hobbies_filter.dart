import 'package:dweller/services/controller/search/searchpage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class FilterHobbiesList extends StatefulWidget {
  const FilterHobbiesList({super.key,});

  @override
  State<FilterHobbiesList> createState() => _FilterHobbiesListState();
}

class _FilterHobbiesListState extends State<FilterHobbiesList> {

  final searchPageController = Get.put(SearchPageController());
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.h, //200.h
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 30, //10,
          mainAxisSpacing: 20, //10,
          childAspectRatio: 0.4, //0.35 Adjust this ratio as needed to control the item size
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: searchPageController.mainHobbiesList.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        //padding: EdgeInsets.symmetric(horizontal: 10.w),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (searchPageController.selectedMainHobbiesList.contains(searchPageController.mainHobbiesList[index])) {
                  searchPageController.selectedMainHobbiesList.remove(searchPageController.mainHobbiesList[index]);
                  debugPrint("selected hobbies: ${searchPageController.selectedMainHobbiesList}");
                } 
                else {
                  searchPageController.selectedMainHobbiesList.add(searchPageController.mainHobbiesList[index]);
                  debugPrint("selected hobbies: ${searchPageController.selectedMainHobbiesList}");
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              height: 40.h,
              //width: 180.w,
              //width: index.isEven ? 80.w : 160.w,
              decoration: BoxDecoration(          
                color: searchPageController.selectedMainHobbiesList.contains(searchPageController.mainHobbiesList[index]) ? AppColor.blueColor : AppColor.greyColor,
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                  color: searchPageController.selectedMainHobbiesList.contains(searchPageController.mainHobbiesList[index]) ? AppColor.blueColor : AppColor.greyColor
                )
              ),
              child: Text(
                searchPageController.mainHobbiesList[index],  //${index}
                style: GoogleFonts.poppins(
                  color: searchPageController.selectedMainHobbiesList.contains(searchPageController.mainHobbiesList[index]) ? AppColor.whiteColor : AppColor.neutralBlackColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )
            ),
          );
        }
      ),
    );
  }
}