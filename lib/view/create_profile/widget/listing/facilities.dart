import 'dart:developer';
import 'package:dweller/services/controller/home/listing/listing_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';







class PropertyFacilities extends StatefulWidget {
  const PropertyFacilities({super.key});

  @override
  State<PropertyFacilities> createState() => _PropertyFacilitiesState();
}

class _PropertyFacilitiesState extends State<PropertyFacilities> {

  final controller = Get.put(ListingController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 210.h, //200.h
      height: MediaQuery.of(context).size.height * 0.35, //0.35
      //width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15, //10,
          mainAxisSpacing: 20, //10,
          childAspectRatio: 1.0, //1.0, 0.95 //Adjust this ratio as needed to control the item size
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: controller.facilitiesList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemBuilder: (context, index) {

          final data =  controller.facilitiesList[index];

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            //alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColor.lightGreyColor),
              boxShadow: [
                data.isSelected ? BoxShadow(
                  color: AppColor.semiDarkGreyColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3), // changes position of shadow
                ) : BoxShadow(),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Radio widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Checkbox(
                      value: data.isSelected,
                      //groupValue: data.isSelected, //true, data.isSelected,
                      onChanged: (bool? value) {

                        setState(() {
                          data.isSelected = !data.isSelected; 
                          data.isSelected = value!;
                          log("is facility selected = ${data.isSelected}");
                          if (data.isSelected) {
                            controller.selectedFacilitiesList.add(data);
                            debugPrint("selected facility list: ${controller.selectedFacilitiesList}");
                          } 
                          else {
                            controller.selectedFacilitiesList.remove(data);
                            debugPrint("selected facility list: ${controller.selectedFacilitiesList}");
                          }
                        });
                      
                      },
                      activeColor: AppColor.blackColor, //.blackColor, .darkPurpleColor
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    ), 
                  ],
                ),
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data.name,
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500
                        ),
                        //textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    //SizedBox(width: 10.w,),
                    //height: 26.h, width: 26.w,
                    Expanded(
                      child: SvgPicture.asset(
                        data.icon,
                        height: 26.h, 
                        width: 26.w,
                      ),
                    ),
                    
                  ],
                ),
              ],
            )
          );
        }
      )
    );
  }
}