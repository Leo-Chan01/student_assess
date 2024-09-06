import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';

class StudentAssessPage extends StatelessWidget {
  const StudentAssessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.sp, horizontal: 28.sp),
        child: Column(
          children: [
            Text(
              "Assessment",
              style: 28.w700,
            ),
            SizedBox(height: 32.h),
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
                    showBottomSheet(
                        context: context,
                        builder: (context) {
                          return const Row(
                            children: [Text("PDF File"), Text("Image")],
                          );
                        });
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
                        "MCT 508 Course Material.docx",
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
              maxLines: null,
              expands: false,
            ),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 66.h,
              child: MaterialButton(
                onPressed: () {},
                color: AppColor.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.sp)),
                textColor: AppColor.white,
                child: const Text("Submit Summary"),
              ),
            )
          ],
        ),
      )),
    ));
  }

  //   Future<void> _pickFile() async {
  //   List<AssetEntity>? resultList = await AssetPicker.pickAssets(
  //     context,
  //     pickerConfig: AssetPickerConfig(
  //       maxAssets: 1,
  //       requestType: RequestType.all, // Allows picking images, videos, and files
  //     ),
  //   );
  //   if (resultList != null && resultList.isNotEmpty) {
  //     setState(() {
  //       _selectedAsset = resultList.first;
  //     });
  //     _extractTextFromFile(_selectedAsset!);
  //   }
  // }
}
