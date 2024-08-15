import 'dart:developer';

import 'package:dweller/model/settings/credit_card_response.dart';
import 'package:dweller/model/settings/settings_response.dart';
import 'package:dweller/services/controller/settings/settings_controller.dart';
import 'package:dweller/services/repository/settings_service/settings_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/custom_appbar.dart';
import 'package:dweller/utils/components/custom_paint.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/utils/components/my_snackbar.dart';
import 'package:dweller/utils/invention/use_stripe_for_checkout.dart';
import 'package:dweller/utils/invention/use_stripe_for_subscription.dart';
import 'package:dweller/view/subscription/widget/activate_card.dart';
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










class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key, required this.pro, required this.onSettingRefresh});
  final bool pro;
  final VoidCallback onSettingRefresh;

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {


  final controller = Get.put(SettingsController());
  final service = Get.put(SettingService());
  final subscriptionService = StripeSubscriptionClass();

  late Future<CardResponse> cardFuture;

  @override
  void initState() {
    cardFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<CardResponse> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final cardFuture = await service.getUserCard();
    return cardFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      cardFuture = _refresh();
    });
  }

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

                      widget.pro ? Row(
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
                                      onPressed: () async{
                                        await subscriptionService.makePayment(context: context);
                                      },
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
                      )
                      :Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'join',
                            style: GoogleFonts.bricolageGrotesque(
                              color: AppColor.darkPurpleColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(width: 6.w,),
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
                          SizedBox(width: 6.w,),
                          Expanded(
                            child: Text(
                              'and get extra features',
                              style: GoogleFonts.bricolageGrotesque(
                                color: AppColor.darkPurpleColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                      /*widget.pro ? Row(
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
                                    onCancel: () {
                                      Get.back();
                                    },
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
                      )
                      :Text(
                        'No active card',
                        style: GoogleFonts.bricolageGrotesque(
                          color: AppColor.darkPurpleColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),*/
                      
                      
                      //Wrap with Future Builder
                      //card

                      //BlueCardEmpty(),
                      FutureBuilder<CardResponse>(
                        future: cardFuture,
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return const BlueCardEmptyLoading(); //BlueCardEmptyLoading(); //BlueCardEmpty()
                          }
                          if(snapshot.hasError) {
                            log("snapshot err: ${snapshot.error}");
                            return const BlueCardEmpty();
                          }
                          if(!snapshot.hasData) {
                            log("snapshot has data?: ${snapshot.hasData}");
                            return const BlueCardEmpty();
                          }
                          final data = snapshot.data!;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                            onRefresh: () => _handleRefresh(),
                                            service: service,
                                            controller: controller,
                                            cardNumber: data.number,
                                            cardHolderName: data.cardHolderName,
                                            expiryDate: "${data.expMonth}/${data.expYear}",
                                            cvv: data.cvv,
                                          );
                                        },
                                        child: SvgPicture.asset('assets/svg/edit_icon.svg'),
                                      ),
                                      SizedBox(width: 5.w,),
                                      InkWell(
                                        onTap: () {
                                          if(data.active) {
                                            deactivateCardDialog(
                                              onConfirm: () async{
                                                await service.deactivateCreditCard(
                                                  context: context, 
                                                  onSuccess: () {
                                                    _handleRefresh();
                                                    Get.back();
                                                    showMySnackBar(
                                                      context: context, 
                                                      message: "credit card de-activated successfully", 
                                                      backgroundColor: AppColor.greenColor,
                                                    );
                                                  }, 
                                                  onFailure: () {
                                                    Get.back();
                                                    showMySnackBar(
                                                      context: context, 
                                                      message: "failed to de-activate credit card", 
                                                      backgroundColor: AppColor.redColor
                                                    );
                                                  }
                                                );
                                              },
                                              onCancel: () {
                                                Get.back();
                                              },
                                            );
                                          }
                                          else{
                                            activateCardDialog(
                                              onConfirm: () async{
                                                await service.reactivateCreditCard(
                                                  context: context, 
                                                  onSuccess: () {
                                                    _handleRefresh();
                                                    Get.back();
                                                    showMySnackBar(
                                                      context: context, 
                                                      message: "credit card re-activated successfully", 
                                                      backgroundColor: AppColor.greenColor,
                                                    );
                                                  }, 
                                                  onFailure: () {
                                                    Get.back();
                                                    showMySnackBar(
                                                      context: context, 
                                                      message: "failed to re-activate credit card", 
                                                      backgroundColor: AppColor.redColor
                                                    );
                                                  }
                                                );
                                              },
                                              onCancel: () {
                                                Get.back();
                                              },
                                            );
                                          }
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
                              BlueCard(
                                cardNumber: data.number,
                                cardHolderName: data.cardHolderName,
                                expiryMonth: data.expMonth,
                                expiryYear: data.expYear,
                                cvv: data.cvv,
                              ),
                            ],
                          );
                        }
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                      //UPGRADE TO PRO gradient button
                      widget.pro ? const SizedBox.shrink() : SizedBox(
                        height: 60.h,
                        width: double.infinity,
                        child: GradientElevatedButton(
                          onPressed: () {
                            subscriptionBottomsheet(
                              context: context, 
                              settingsController: controller,
                              service: service,
                              onSettingRefresh: widget.onSettingRefresh
                            );
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