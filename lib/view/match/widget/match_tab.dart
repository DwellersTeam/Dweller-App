import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/match/widget/swipes_on_you.dart';
import 'package:dweller/view/match/widget/swipes_on_you_grid.dart';
import 'package:dweller/view/match/widget/your_swipes.dart';
import 'package:dweller/view/match/widget/your_swipes_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';








class MatchListTab extends StatefulWidget {
  const MatchListTab({super.key});

  @override
  State<MatchListTab> createState() => _MatchListTabState();
}

class _MatchListTabState extends State<MatchListTab> with SingleTickerProviderStateMixin {
  
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w), //50.w
            child: AnimatedContainer(
              //padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.blueColorOp,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColor.blueColorOp)
              ),
              duration: const Duration(milliseconds: 100),
              child: Column(
                children: [
                  //added
                  TabBar(                    
                    physics: const BouncingScrollPhysics(),
                    indicatorPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h), //3.w, 3.h
                    indicatorColor: AppColor.blackColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: AppColor.whiteColor,
                    //indicatorWeight: 0.1,
                    labelStyle: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColor.whiteColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    unselectedLabelColor: AppColor.blackColor,
                    labelColor: AppColor.whiteColor,
                    //padding: EdgeInsets.symmetric(horizontal: 10),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: AppColor.blackColor,
                      shape: BoxShape.rectangle,
                    ),
                    controller: tabController,
                    isScrollable: false,
                    tabs: const [
                      Tab(text: 'Your swipes',),
                      Tab(text: 'Swipes on you',),
                    ],
                  ),
                ],
              ),
            ),
          ),
                
          SizedBox(height:20.h),
                      
          //tabbar content here //wrap with future builder
          Expanded(
            child: TabBarView(
              controller: tabController,
              physics: const BouncingScrollPhysics(),
              children: [
                //put the actual list
                /*MatchEmptyState(
                  title: "You haven't matched with anyone yet",
                  subtitle: "You need to swipe right on someone for them to appear on your search list",
                  button: PetiteButton(
                    backgroundColor: AppColor.blackColor,
                    text: 'Start swiping!',
                    onPressed: () {},
                  ),
                ),*/


                YourSwipes(),
                /*YourSwipesGrid(),
                SwipesOnYouGrid(),*/
                SwipesOnYou(),


                /*const MatchEmptyState(
                  title: "No one has matched with you yet",
                  subtitle: "Sit back, relax and watch potential roommies swipe on you in a bit",
                )*/
              ]
            ),
          ),
          //SizedBox(height:40.h),
        ],
      ),
    );
  }
}