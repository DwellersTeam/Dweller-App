import 'package:dweller/services/controller/create_profile/create_profile_controller.dart';
import 'package:dweller/utils/colors/appcolor.dart';
import 'package:dweller/view/search/settings/widget/general/all_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';








class DisplayPicList extends StatefulWidget {
  const DisplayPicList({super.key, required this.displayPicturesList, required this.onAdd, required this.onDelete});
  final VoidCallback onAdd;
  final VoidCallback onDelete;
  final List<dynamic> displayPicturesList;

  @override
  State<DisplayPicList> createState() => _DisplayPicListState();
}

class _DisplayPicListState extends State<DisplayPicList> {

  final createProfileController = Get.put(CreateProfileController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 250.h, //120.h
          child: ListView.separated(
            //padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const BouncingScrollPhysics(),
            itemCount: widget.displayPicturesList.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 15.w,),
            itemBuilder: (context, index) {
              final item = widget.displayPicturesList[index];
              return InkWell(
                onTap: () {
                  setState(() {
                    if(createProfileController.selectedPicsForDeletion.contains(item)) {
                      createProfileController.selectedPicsForDeletion.remove(item);
                      debugPrint("selected pic for deletion: ${createProfileController.selectedPicsForDeletion}");
                    }
                    else{
                      createProfileController.selectedPicsForDeletion.add(item);
                      debugPrint("selected pic for deletion: ${createProfileController.selectedPicsForDeletion}");
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: createProfileController.selectedPicsForDeletion.contains(item) ? AppColor.darkGreyColor : AppColor.greyColor,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: const [BoxShadow()]
                  ),
                  child: Image.network(
                    widget.displayPicturesList[index], 
                    height: 400.h, //60.h
                    //width: 200.w, //120.w, 
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                )
        
              );
            }
          ),
        ),
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            createProfileController.selectedPicsForDeletion.isNotEmpty ?
            DeletePictureButton(
              onPressed: widget.onDelete,
              text: "Keep", //'Delete',
              width: 110.w,
            )
            :DeletePictureButton2(
              onPressed: widget.onDelete,
              text: 'Delete all',
              width: 125.w,
            ),

            widget.displayPicturesList.length < 2 ? SizedBox(width: 10.w,) : SizedBox.shrink(),

            widget.displayPicturesList.length < 2 ?
            AddPictureButton(
              onPressed: widget.onAdd,
              text: 'Add',
              width: 110.w,
            ): SizedBox.shrink(),
          ],
        )
      ],
    );
  }
}