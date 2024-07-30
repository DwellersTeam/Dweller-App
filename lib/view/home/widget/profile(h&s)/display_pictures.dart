import 'package:cached_network_image/cached_network_image.dart';
import 'package:dweller/services/controller/home/homepage_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';







class ProfileDisplayPictures extends StatelessWidget {
  const ProfileDisplayPictures({super.key, required this.pictures, required this.onTap});
  final List<dynamic> pictures;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.h, //120.h
      //width: 150.w,
      child: ListView.separated(
        //padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: pictures.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => SizedBox(width: 20.w,),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: onTap,
            child: CachedNetworkImage(
              imageUrl: pictures[index],
              height: 400.h, //60.h
              //width: 600.w,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            )
          );
        }
      ),
    );
  }
}