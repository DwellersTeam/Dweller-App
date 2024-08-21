import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';






class SwitchWidget extends StatelessWidget {
  SwitchWidget({super.key, required this.onChanged, required this.isToggled});
  final void Function(bool)? onChanged;
  bool isToggled;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: CupertinoSwitch(
        activeColor: AppColor.blueColor,
        thumbColor: AppColor.blueColorOp,
        trackColor: AppColor.chatGreyColor.withOpacity(0.2),
        value: isToggled,
        onChanged: onChanged
      ),
    );
  }
}