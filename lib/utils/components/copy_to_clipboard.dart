import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';







void showClipboardSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      dismissDirection: DismissDirection.down,
      backgroundColor: const Color.fromARGB(0, 56, 195, 238), //.withOpacity(0.1),
      showCloseIcon: false,
      content: Text(
        textAlign: TextAlign.center,
        message,
        style: GoogleFonts.poppins(
          color: AppColor.whiteColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.normal
        ),
      ),
      duration: Duration(seconds: 2), // Adjust the duration as needed
      /*action: SnackBarAction(
        label: 'CLOSE',
        onPressed: () {
          // Perform an action when the user presses the action button
        },
      ),*/
    ),
  );
}


//to copy text to clipboard
Future<void> copyToClipboard({required String text, required String snackMessage, required BuildContext context}) async{
  Clipboard.setData(ClipboardData(text: text)).whenComplete(() => showClipboardSnackBar(context, snackMessage));
}