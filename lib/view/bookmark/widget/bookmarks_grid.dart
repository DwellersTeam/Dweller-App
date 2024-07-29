import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';




class BookmarkGrid extends StatelessWidget {
  const BookmarkGrid({super.key});

  //
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator.adaptive(
        color: AppColor.whiteColor,
        backgroundColor: AppColor.darkPurpleColor,
        onRefresh: () => _refresh(),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 8,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.h, //10,
            mainAxisSpacing: 20.w, //10,
            childAspectRatio: 0.9, //0.3 Adjust this ratio as needed to control the item size
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          //separatorBuilder: (context, index) => SizedBox(height: 10.h,),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.blueColorLightest,
                borderRadius: BorderRadius.circular(15.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.darkGreyColor.withOpacity(0.2), //.blackColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ], //32 500w
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundColor: Colors.grey.withOpacity(0.1),
                        backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                        /*child: Text(
                          'J',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),*/
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          CupertinoIcons.bookmark_fill,
                          color: AppColor.darkPurpleColor,
                          size: 24.r,
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 30.h,),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          'Jimmy Neutron',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                          overflow: TextOverflow.clip  //ellipsis,
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Icon(
                        //isGridview ? isListView
                        CupertinoIcons.checkmark_seal_fill,
                        color: AppColor.blueColor,
                        size: 24.r,
                      ),
                      SizedBox(width: 10.w,),
                      Text(
                        '20',
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    '8, Abimbola Cole Ikoyi, Lagos',
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                    overflow: TextOverflow.clip,
                  ),
            
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}