import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/view/subscription/widget/deactivate_card.dart';
import 'package:dweller/view/subscription/widget/debit_card.dart';
import 'package:dweller/view/subscription/widget/edit_card.dart';
import 'package:dweller/view/subscription/widget/features.dart';
import 'package:dweller/view/subscription/widget/pay_with_card.dart';
import 'package:dweller/view/subscription/widget/subscription_bottomsheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';






class SubscriptionPage extends StatelessWidget {
  SubscriptionPage({super.key});

  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: CustomPaint(
          painter: TopRedSectionPainter(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //appbar
              DwellerAppBar(
                actionIcon: SvgPicture.asset('assets/svg/settings_icon.svg'),
              ),
              //SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Subscriptions and Payments',
                  style: GoogleFonts.bricolageGrotesque(
                    color: AppColor.darkPurpleColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              SizedBox(height: 25.h,),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //subscription status 
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'You are currently on',
                                style: GoogleFonts.bricolageGrotesque(
                                  color: AppColor.darkPurpleColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 5.h,),
                              Row(
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
                                            Color.fromRGBO(9, 173, 234, 1),
                                            Color.fromRGBO(41, 57, 238, 1),

                                           //AppColor.blueColorGradient2,
                                           //AppColor.blueColorGradient1,
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
                          
                            ],
                          ),
                          SizedBox(width: 20.w,),
                          CircleAvatar(
                            radius: 26.r,
                            backgroundColor: AppColor.blueColorGradient1,
                            child: CircleAvatar(
                              radius: 24.r,
                              backgroundColor: Colors.grey.withOpacity(0.1),
                              backgroundImage: const AssetImage("assets/images/lionel.jpg"),
                              /*child: Text(
                                'J',
                                style: GoogleFonts.poppins(
                                 color: AppColor.blackColor,
                                 ontSize: 16.sp,
                                fontWeight: FontWeight.w500
                                ),
                              ),*/
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      //sub features
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SubFeatureCard(
                            svgAsset: 'assets/svg/nonstop_chat.svg',
                            text: 'Chat Freely',
                          ),
                          SizedBox(width: 10.w),
                          const SubFeatureCard(
                            svgAsset: 'assets/svg/search_faster.svg',
                            text: 'Search Faster',
                          ),
                          SizedBox(width: 10.w),
                          const SubFeatureCard(
                            svgAsset: 'assets/svg/unlimited_swipe.svg',
                            text: 'Swipe nonstop',
                          )
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                      //edit and delete actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Card',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  editCardBottomsheet(
                                    context: context,
                                    controller: controller,
                                    cardNumber: '2345 5657 3456 1233',
                                    cardHolderName: 'Calvin Harris',
                                    expiryDate: '10/28',
                                    cvv: '234',
                                  );
                                },
                                child: SvgPicture.asset('assets/svg/edit_icon.svg'),
                              ),
                              SizedBox(width: 5.w,),
                              InkWell(
                                onTap: () {
                                  deactivateCardDialog(
                                    onConfirm: () {},
                                    onCancel: () {},
                                  );
                                },
                                child: Icon(
                                  size: 19.r,
                                  color: AppColor.darkGreyColor,
                                  CupertinoIcons.info_circle
                                ),
                              ),
                              
                            ],
                          ),
                          //active / deactivate card
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      //card
                      //BlueCardEmpty(),
                      const BlueCard(
                        cardNumber: '2345 5657 3456 1233',
                        cardHolderName: 'Calvin Harris',
                        expiryDate: '10/28',
                        cvv: '234',
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                      //UPGRADE TO PRO gradient button
                      SizedBox(
                        height: 60.h,
                        width: double.infinity,
                        child: GradientElevatedButton(
                          onPressed: () {
                            subscriptionBottomsheet(context: context, settingsController: controller);
                          },
                          style: GradientElevatedButton.styleFrom(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(9, 173, 234, 1),
                                Color.fromRGBO(41, 57, 238, 1),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Text(
                            'Upgrade to PRO',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.whiteColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),


                    ]
                  )
                )
              )
            ]

          )
        )
      )
    );
  }
}