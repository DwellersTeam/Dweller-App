import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/main.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/invention/use_stripe_for_subscription.dart';
import 'package:dweller/view/subscription/widget/features_box.dart';
import 'package:dweller/view/subscription/widget/pay_with_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';







Future<void> subscriptionBottomsheet({
  required BuildContext context,
  required SettingsController settingsController,
  required SettingService service,
  required VoidCallback onSettingRefresh,
  required StripeSubscriptionClass subscriptionService,

  }) async{

  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColorForSubSheet,  //whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.95, //0.75,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColorForSubSheet, //whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                  ),
                ), 

                SizedBox(height: 20.h),

                //sub logo row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //1
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/svg/sub_logo.svg"),
                          SizedBox(width: 6.w,),
                          Text(
                            'dweller',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(width: 6.w,),
                          ///gradient button
                          SizedBox(
                            height: 25.h,
                            //width: 50.w,
                            child: GradientElevatedButton(
                              onPressed: () {},
                              style: GradientElevatedButton.styleFrom(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColor.blueColorGradient2,
                                    AppColor.blueColorGradient1,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Text(
                                'PRO',
                                style: GoogleFonts.bricolageGrotesque(
                                  color: AppColor.whiteColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        size: 24.r,
                        color: AppColor.semiDarkGreyColor,
                        CupertinoIcons.xmark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),

                ////Scrollable
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            //color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: AssetImage('assets/images/lionel.jpg'),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        //
                        SizedBox(height: 40.h,),
                        Text(
                          'Join the PRO dwellers and get extra features',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.darkPurpleColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 20.h,),
                        FeaturesBox(
                          svgImage: SvgPicture.asset('assets/svg/unlimited_swipes.svg'),
                          title: 'Unlimited Swipes',
                          subtitle: "Swipes to your heart's content without limits!",
                        ),
                        SizedBox(height: 20.h,),
                        FeaturesBox(
                          svgImage: SvgPicture.asset('assets/svg/chat_freely.svg'),
                          title: 'Chat Freely',
                          subtitle: "Engage with countless Dwellers and spark connections effortlessly.",
                        ),
                        SizedBox(height: 20.h,),
                        FeaturesBox(
                          svgImage: SvgPicture.asset('assets/svg/enhanced_search.svg'),
                          title: 'Enhanced Search',
                          subtitle: "Find your perfect match with precision using advanced search.",
                        ),
                        SizedBox(height: 30.h,),
                        SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: GradientElevatedButton(
                            onPressed: () async{
                              await subscriptionService.makePayment(context: context)
                              .whenComplete((){
                                Get.back();
                              });
                              /*Get.back();
                              payWithCardBottomsheet(
                                onSettingRefresh: onSettingRefresh,
                                context: context,
                                controller: settingsController,
                                service: service
                              );*/
                            },
                            style: GradientElevatedButton.styleFrom(
                              gradient: const LinearGradient(
                                colors: [
                                AppColor.blueColorGradient2,
                                AppColor.blueColorGradient1,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Obx(
                              () {
                                return subscriptionService.isLoading.value ? const CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Join ',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'PRO ',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'for ',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${currency(context).currencySymbol}7.99/month',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ]
                                  )
                                );
                              }
                            )
                          ),
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                ),
              
                
              ],
            ),
          ),
        ],
      );
    }
  );
}






Future<void> subscriptionBottomsheetAdvancedSearch({
  required BuildContext context,
  required SettingsController settingsController,
  required SettingService service,
  required StripeSubscriptionClass subscriptionService,
  }) async{

  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.whiteColorForSubSheet,  //whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.95, //0.75,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: AppColor.whiteColorForSubSheet, //whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    width: 50.w,
                    decoration: BoxDecoration(
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(15.r)
                    ),
                  ),
                ), 

                SizedBox(height: 20.h),

                //sub logo row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //1
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/svg/sub_logo.svg"),
                          SizedBox(width: 6.w,),
                          Text(
                            'dweller',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(width: 6.w,),
                          ///gradient button
                          SizedBox(
                            height: 25.h,
                            //width: 50.w,
                            child: GradientElevatedButton(
                              onPressed: () {},
                              style: GradientElevatedButton.styleFrom(
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColor.blueColorGradient2,
                                    AppColor.blueColorGradient1,
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: Text(
                                'PRO',
                                style: GoogleFonts.bricolageGrotesque(
                                  color: AppColor.whiteColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        size: 24.r,
                        color: AppColor.semiDarkGreyColor,
                        CupertinoIcons.xmark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h,),

                ////Scrollable
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            //color: AppColor.greyColor,
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                              image: AssetImage('assets/images/lionel.jpg'),
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        //
                        SizedBox(height: 40.h,),
                        Text(
                          'Join the PRO dwellers and get extra features',
                          style: GoogleFonts.bricolageGrotesque(
                            color: AppColor.darkPurpleColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: 20.h,),
                        FeaturesBox(
                          svgImage: SvgPicture.asset('assets/svg/unlimited_swipes.svg'),
                          title: 'Unlimited Swipes',
                          subtitle: "Swipes to your heart's content without limits!",
                        ),
                        SizedBox(height: 20.h,),
                        FeaturesBox(
                          svgImage: SvgPicture.asset('assets/svg/chat_freely.svg'),
                          title: 'Chat Freely',
                          subtitle: "Engage with countless Dwellers and spark connections effortlessly.",
                        ),
                        SizedBox(height: 20.h,),
                        FeaturesBox(
                          svgImage: SvgPicture.asset('assets/svg/enhanced_search.svg'),
                          title: 'Enhanced Search',
                          subtitle: "Find your perfect match with precision using advanced search.",
                        ),
                        SizedBox(height: 30.h,),
                        SizedBox(
                          height: 50.h,
                          width: double.infinity,
                          child: GradientElevatedButton(
                            onPressed: () async{
                              await subscriptionService.makePayment(context: context)
                              .whenComplete((){
                                Get.back();
                              });
                          
                            },
                            style: GradientElevatedButton.styleFrom(
                              gradient: const LinearGradient(
                                colors: [
                                AppColor.blueColorGradient2,
                                AppColor.blueColorGradient1,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Obx(
                              () {
                                return subscriptionService.isLoading.value ? const CircularProgressIndicator.adaptive(backgroundColor: AppColor.whiteColor,) : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Join ',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'PRO ',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'for ',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '${currency(context).currencySymbol}7.99/month',
                                        style: GoogleFonts.bricolageGrotesque(
                                          color: AppColor.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ]
                                  )
                                );
                              }
                            )
                          ),
                        ),
                        SizedBox(height: 20.h,),
                      ],
                    ),
                  ),
                ),
              
                
              ],
            ),
          ),
        ],
      );
    }
  );
}

