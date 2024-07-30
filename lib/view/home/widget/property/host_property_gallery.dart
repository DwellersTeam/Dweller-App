import 'package:cached_network_image/cached_network_image.dart';
import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';








class HostApartmentGallery extends StatelessWidget {
  const HostApartmentGallery({super.key, required this.pictures});
  final List<dynamic> pictures;

  //final controller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h, //120.h
      //width: 150.w,
      child: ListView.separated(
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: pictures.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 15.w,),
        itemBuilder: (context, index) {

          final data = pictures[index];

          return InkWell(
            onTap: () {},
            child: CachedNetworkImage(
              imageUrl: data,        
              height: 400.h, //60.h
              width: 200.w, //120.w
              fit: BoxFit.cover,
            )
          );
        }
      ),
    );
  }
}