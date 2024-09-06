import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/providers/file_picker_provider.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';

class StudentAssessPage extends StatelessWidget {
  const StudentAssessPage({super.key});

  static final TextEditingController inputcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fileProvider = context.watch<FilePickerProvider>();
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 28.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Assessment",
              style: 32.w700,
            ),
            SizedBox(height: 64.h),
            Container(
              height: 80.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: InkWell(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      topRadius: Radius.circular(12.sp),
                      builder: (context) => SizedBox(
                        height: 100.h,
                        child: Scaffold(
                          body: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24.sp, vertical: 16.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MaterialButton(
                                  onPressed: () async {
                                    await fileProvider.pickPDF();
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.sp)),
                                  color: AppColor.black,
                                  textColor: AppColor.white,
                                  child: Text(
                                    "PDF File",
                                    style: 16.w600,
                                  ),
                                ),
                                SizedBox(width: 50.w),
                                MaterialButton(
                                  onPressed: () async {
                                    await fileProvider.pickImageFile(context);
                                  },
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.sp)),
                                  color: AppColor.grey.withOpacity(0.1),
                                  textColor: AppColor.black,
                                  child: Text(
                                    "Image",
                                    style: 16.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.doc_richtext,
                        color: AppColor.orange,
                        size: 34.sp,
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        fileProvider.fileName,
                        style: 14.w600,
                      ),
                      const Spacer(),
                      Icon(CupertinoIcons.cloud_upload, color: AppColor.grey)
                    ],
                  ),
                ),
              )),
            ),
            SizedBox(height: 32.h),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Write your summary here",
                  fillColor: AppColor.grey.withOpacity(0.1),
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12.r))),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              controller: inputcontroller,
              maxLines: null,
              expands: false,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 66.h,
              child: MaterialButton(
                onPressed: () async {
                  if (fileProvider.selectedAsset == null) {
                  } else {
                    if (inputcontroller.text.trim().toString().isNotEmpty) {
                      log("In here");
                      await fileProvider
                          .updateUserInput(
                              inputcontroller.text.trim().toString())
                          .then((value) {
                        fileProvider.calculateSimilarity();
                      });
                    } else {}
                  }
                },
                color: AppColor.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp)),
                textColor: AppColor.white,
                child: Text(
                  fileProvider.feedbackText,
                  style: 16.w700,
                ),
              ),
            ),
            SizedBox(height: 64.h),
            Text("Assessment Score", textAlign: TextAlign.left, style: 30.w600),
            SizedBox(height: 24.h),
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColor.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.sp)),
              child: Center(
                  child:
                      Text("${fileProvider.similarityScore.roundToDouble()}%")),
            )
          ],
        ),
      )),
    ));
  }
}
