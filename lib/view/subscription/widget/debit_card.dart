import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';




class BlueCard extends StatelessWidget {
  const BlueCard({super.key, required this.cardNumber, required this.cardHolderName, required this.expiryMonth, required this.expiryYear, required this.cvc,});
  final String cardNumber;
  final String cardHolderName;
  final int expiryMonth;
  final int expiryYear;
  final String cvc;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: [
            Color.fromRGBO(9, 173, 234, 1),
            Color.fromRGBO(41, 57, 238, 1),
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SvgPicture.asset("assets/svg/wallet.svg", width: 48.w, height: 48.h,),
          Text(
            cardNumber,
            style: GoogleFonts.bricolageGrotesque(
              color: AppColor.whiteColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder Name',
                      style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Text(
                      cardHolderName,
                      style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ],
                ),
              ),

              SizedBox(width: 30.w,),

              //2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    "$expiryMonth/$expiryYear",
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  
                ],
              ),

              SizedBox(width: 30.w,),

              //3
              SvgPicture.asset('assets/svg/master_card.svg'),
              /*Icon(
                CupertinoIcons.creditcard_fill,
                size: 40.sp,
                color: AppColor.redColor,
              ),*/


            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Text(
            'CVV',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 5.h,),
          Text(
            "$cvc",
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          
        ],
      ),
    );
  }
}




class BlueCardEmpty extends StatelessWidget {
  const BlueCardEmpty({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: [
            Color.fromRGBO(9, 173, 234, 1),
            Color.fromRGBO(41, 57, 238, 1),
          ]
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //SvgPicture.asset("assets/svg/wallet.svg", width: 48.w, height: 48.h,),
          Text(
            '---- ---- ---- ----',
            style: GoogleFonts.bricolageGrotesque(
              color: AppColor.whiteColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder Name',
                      style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    Text(
                      '----',
                      style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    
                  ],
                ),
              ),

              SizedBox(width: 30.w,),

              //2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    '--/--',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  
                ],
              ),

              SizedBox(width: 30.w,),

              //3
              SvgPicture.asset('assets/svg/master_card.svg'),
              /*Icon(
                CupertinoIcons.creditcard_fill,
                size: 40.sp,
                color: AppColor.redColor,
              ),*/


            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          Text(
            'CVV',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 5.h,),
          Text(
            '----',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          
        ],
      ),
    );
  }
}





class BlueCardEmptyLoading extends StatelessWidget {
  const BlueCardEmptyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          colors: [
            Color.fromRGBO(9, 173, 234, 1),
            Color.fromRGBO(41, 57, 238, 1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card number shimmer effect
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Text(
              '---- ---- ---- ----',
              style: GoogleFonts.bricolageGrotesque(
                color: AppColor.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1 - Card holder name shimmer effect
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Holder Name',
                      style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 5),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Text(
                        '----',
                        style: GoogleFonts.poppins(
                          color: AppColor.whiteColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30),
              // 2 - Expiry date shimmer effect
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expiry Date',
                    style: GoogleFonts.poppins(
                      color: AppColor.whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 5),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Text(
                      '--/--',
                      style: GoogleFonts.poppins(
                        color: AppColor.whiteColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 30),
              // 3 - SVG or Icon
              SvgPicture.asset('assets/svg/master_card.svg'),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            'CVV',
            style: GoogleFonts.poppins(
              color: AppColor.whiteColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 5),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            enabled: true,
            child: Text(
              '----',
              style: GoogleFonts.poppins(
                color: AppColor.whiteColor,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}