import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:student_assess/view_model/providers/file_picker_provider.dart';
import 'package:student_assess/view_model/utils/config/color.dart';
import 'package:student_assess/view_model/utils/extension/num_extension.dart';
import 'package:student_assess/views/widgets/student_assess_button_widget.dart';
import 'package:student_assess/views/widgets/student_assess_textfield_widget.dart';

class StudentAssessPage extends StatelessWidget {
  const StudentAssessPage({super.key});

  static final TextEditingController inputcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var fileProvider = context.watch<FilePickerProvider>();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.sp, horizontal: 28.sp),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assessment",
                style: 32.w700,
              ),
              SizedBox(height: 28.h),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            color: AppColor.primary,
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            "How it works",
                            style: 18.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Test your understanding with our AI-powered assessment system:",
                        style: 16.w400.copyWith(
                            color: AppColor.onSurface.withOpacity(0.8)),
                      ),
                      SizedBox(height: 12.h),
                      _buildInstructionStep(
                          "1",
                          "Upload course material (PDF or Image)",
                          Icons.upload_file),
                      SizedBox(height: 8.h),
                      _buildInstructionStep("2",
                          "Write a comprehensive summary", Icons.edit_note),
                      SizedBox(height: 8.h),
                      _buildInstructionStep("3",
                          "Get instant AI-powered scoring", Icons.analytics),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "Upload Material",
                style: 20.w600,
              ),
              SizedBox(height: 16.h),
              Card(
                child: InkWell(
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      topRadius: Radius.circular(20.sp),
                      builder: (context) => Container(
                        height: 180.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.sp)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.sp, vertical: 20.sp),
                          child: Column(
                            children: [
                              Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: AppColor.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2.sp),
                                ),
                              ),
                              SizedBox(height: 24.h),
                              Text(
                                "Choose File Type",
                                style: 18.w600,
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildFileTypeButton(
                                      context,
                                      "PDF Document",
                                      Icons.picture_as_pdf,
                                      AppColor.error,
                                      () async => await fileProvider.pickPDF(),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: _buildFileTypeButton(
                                      context,
                                      "Image File",
                                      Icons.image,
                                      AppColor.primary,
                                      () async => await fileProvider
                                          .pickImageFile(context),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12.sp),
                  child: Container(
                    padding: EdgeInsets.all(20.sp),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: fileProvider.selectedAsset != null
                                ? AppColor.primary.withOpacity(0.1)
                                : AppColor.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Icon(
                            fileProvider.selectedAsset != null
                                ? Icons.check_circle
                                : Icons.upload_file,
                            color: fileProvider.selectedAsset != null
                                ? AppColor.primary
                                : AppColor.grey,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fileProvider.selectedAsset != null
                                    ? "File Selected"
                                    : "No file selected",
                                style: 14.w600.copyWith(
                                      color: fileProvider.selectedAsset != null
                                          ? AppColor.primary
                                          : AppColor.grey,
                                    ),
                              ),
                              if (fileProvider.selectedAsset != null) ...[
                                SizedBox(height: 4.h),
                                Text(
                                  fileProvider.fileName,
                                  style: 12.w400.copyWith(color: AppColor.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ] else ...[
                                SizedBox(height: 4.h),
                                Text(
                                  "Tap to upload PDF or image",
                                  style: 12.w400.copyWith(color: AppColor.grey),
                                ),
                              ]
                            ],
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.grey,
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                "Write Your Summary",
                style: 20.w600,
              ),
              SizedBox(height: 16.h),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(4.sp),
                  child: StudentAssessTextField(
                    inputcontroller: inputcontroller,
                    hintText:
                        "Write a comprehensive summary of the material...",
                    maxLinesNeeded: 8,
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              if (fileProvider.isLoading)
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColor.primary),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          fileProvider.feedbackText,
                          style: 16.w500,
                        ),
                      ],
                    ),
                  ),
                )
              else
                StudentAssessButton(
                  pressedAction: () async {
                    if (fileProvider.selectedAsset == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please upload a file first"),
                          backgroundColor: AppColor.error,
                        ),
                      );
                    } else {
                      if (inputcontroller.text.trim().toString().isNotEmpty) {
                        log("In here");
                        await fileProvider
                            .updateUserInput(
                                inputcontroller.text.trim().toString())
                            .then((value) {
                          fileProvider.calculateSimilarityFromAPI();
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please write a summary first"),
                            backgroundColor: AppColor.warning,
                          ),
                        );
                      }
                    }
                  },
                  buttonText: fileProvider.feedbackText,
                  buttonColor: AppColor.primary,
                  buttonTextColor: AppColor.background,
                ),
              SizedBox(height: 32.h),
              _buildScoreCard(fileProvider.similarityScore),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildInstructionStep(String number, String text, IconData icon) {
    return Row(
      children: [
        Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: AppColor.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: 12.w600.copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Icon(
          icon,
          size: 16.sp,
          color: AppColor.grey,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: 14.w400.copyWith(color: AppColor.onSurface.withOpacity(0.8)),
          ),
        ),
      ],
    );
  }

  Widget _buildFileTypeButton(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 0,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: 12.w500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(double score) {
    Color scoreColor = AppColor.getScoreColor(score);
    String scoreText = _getScoreText(score);
    IconData scoreIcon = _getScoreIcon(score);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(24.sp),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: AppColor.primary,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  "Assessment Score",
                  style: 20.w600,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scoreColor.withOpacity(0.1),
                border: Border.all(color: scoreColor, width: 3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    scoreIcon,
                    color: scoreColor,
                    size: 32.sp,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "${score.round()}%",
                    style: 24.w700.copyWith(color: scoreColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              scoreText,
              style: 16.w500.copyWith(color: scoreColor),
              textAlign: TextAlign.center,
            ),
            if (score > 0) ...[
              SizedBox(height: 16.h),
              Text(
                _getScoreDescription(score),
                style: 14
                    .w400
                    .copyWith(color: AppColor.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }

  String _getScoreText(double score) {
    if (score >= 80) return "Excellent!";
    if (score >= 70) return "Good Job!";
    if (score >= 40) return "Not Bad";
    if (score > 0) return "Needs Improvement";
    return "No Score Yet";
  }

  IconData _getScoreIcon(double score) {
    if (score >= 80) return Icons.emoji_events;
    if (score >= 70) return Icons.thumb_up;
    if (score >= 40) return Icons.trending_up;
    if (score > 0) return Icons.trending_down;
    return Icons.help_outline;
  }

  String _getScoreDescription(double score) {
    if (score >= 80)
      return "Your summary shows excellent understanding of the material!";
    if (score >= 70) return "Good work! Your summary covers most key points.";
    if (score >= 40)
      return "Your summary captures some important concepts. Try to include more details.";
    return "Your summary needs more detail. Focus on the main concepts and key information.";
  }
}
