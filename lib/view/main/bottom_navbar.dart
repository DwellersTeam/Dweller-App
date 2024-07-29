import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';





class BottomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int selectedIndex;
  final List<BottomNavigationBarItem> items;
  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped, 
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColor.whiteColor,
      selectedItemColor: AppColor.darkPurpleColor,
      unselectedItemColor: AppColor.lightGreyColor,
      items: items,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      iconSize: 29.sp,
      onTap: onItemTapped,
      elevation: 0, //8,
      selectedLabelStyle: GoogleFonts.poppins(),
      unselectedLabelStyle: GoogleFonts.poppins(),
    );
  }
}