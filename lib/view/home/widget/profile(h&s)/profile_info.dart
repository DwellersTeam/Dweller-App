import 'dart:developer';

import 'package:dweller/model/profile/user_profile_model.dart';
import 'package:dweller/services/repository/create_profile_service/create_profile_service.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/utils/components/extractors.dart';
import 'package:dweller/utils/components/loader.dart';
import 'package:dweller/view/home/widget/profile(h&s)/detail_card.dart';
import 'package:dweller/view/home/widget/profile(h&s)/display_pictures.dart';
import 'package:dweller/view/home/widget/profile(h&s)/hobbies_list.dart';
import 'package:dweller/view/home/widget/profile(h&s)/lifestyle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';





//Get Profile by id
class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {

  final profileService = Get.put(CreateProfileService());

  late Future<UserModel> profileFuture;

  @override
  void initState() {

    profileFuture = _refresh();
    super.initState();
  }


  //REFRESH FUNCTIONALITY
  Future<UserModel> _refresh() async{
    await Future.delayed(const Duration(seconds: 2));
    final profileFuture = await profileService.getUserByIdEndpoint(context: context, id: widget.user.id);
    return profileFuture;
  }


  Future<void> _handleRefresh() async{
    setState(() {
      profileFuture = _refresh();
    });
  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder<UserModel>(
      future: profileFuture,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: const LoaderS());
        }
        if(snapshot.hasError){
          log("snapshot err: ${snapshot.error}");
          return Center(
            child: Text(
              "An error occurred",
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600
              )
            ),
          );
        }
        if(!snapshot.hasData){
          log("snapshot has data?: ${snapshot.hasData}");
          return Center(
            child: Text(
              "User not found",
              style: GoogleFonts.poppins(
                color: AppColor.darkPurpleColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600
              )
            ),
          );
        }
              
        final data = snapshot.data!;

        return RefreshIndicator.adaptive(
          color: AppColor.whiteColor,
          backgroundColor: AppColor.darkPurpleColor,
          onRefresh: () => _handleRefresh(),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                /*borderRadius: BorderRadius.circular(50.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.semiDarkGreyColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],*/
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
          
                  //Profile Details
                  AnimatedContainer(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    //height: 60.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.blueColorLightest,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColor.blueColorLightest),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.lightGreyColor.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    duration: const Duration(milliseconds: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //profile Avatar
                        data.displayPicture.isNotEmpty
                        ?CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          backgroundImage: NetworkImage(data.displayPicture),
                          /*child: Text(
                            'J',
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),*/
                        )
                        :CircleAvatar(
                          radius: 24.r,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                          child: Text(
                            getFirstLetter(data.firstname),
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${data.firstname} ${data.lastname}",
                              style: GoogleFonts.poppins(
                                color: AppColor.neutralBlackColorOp,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600
                              )
                            ),
                            SizedBox(width: 10.w,),
                            Icon(
                              color: AppColor.blueColor,
                              size: 22.r,
                              CupertinoIcons.checkmark_seal_fill
                            ),
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Age  ",
                                style: GoogleFonts.poppins(
                                  color: AppColor.neutralBlackColorOp,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              TextSpan(
                                text: "${data.age}      ",
                                style: GoogleFonts.poppins(
                                  color: AppColor.neutralBlackColorOp,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              TextSpan(
                                text: "Sign  ",
                                style: GoogleFonts.poppins(
                                  color: AppColor.neutralBlackColorOp,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              TextSpan(
                                text: "${data.zodiac}",
                                style: GoogleFonts.poppins(
                                  color: AppColor.neutralBlackColorOp,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ]
                          )
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        Text(
                          '"${data.bio}"',
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600
                          ),
                          overflow: TextOverflow.fade,
                        )
                      ]
                    )
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
                  //Occupation
                  ProfileDetailCard(
                    title: "Occupation/Business",
                    child: Text(
                      data.job,
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
                  //Location
                  ProfileDetailCard(
                    title: "Location",
                    child: Text(
                      data.location.address,
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
                  //Hobbies & Interests
                  ProfileDetailCard(
                    title: "Hobbies & Interests",
                    child: ProfileHobbiesList(
                      hobbiesList: data.preferences.interests,
                    ),
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          
                  //Lifestyle
                  ProfileDetailCard(
                    title: "Lifestyle",
                    child: ProfileLifestyleList(
                      lifestyleList: data.preferences.livelihood
                    ),
                  ),
          
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  Text(
                    "Display Pictures",
                    style: GoogleFonts.poppins(
                      color: AppColor.blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ProfileDisplayPictures(
                    pictures: data.pictures,
                    onTap: () {},
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ]
              )
            ),
          ),
        );
      }
    );
  }
}