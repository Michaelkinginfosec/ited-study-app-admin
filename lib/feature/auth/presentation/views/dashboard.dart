// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ited_study_app_admin/core/constants/boxsize.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/presentation/views/upload_course_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_note/presentation/views/upload_note_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_past_exam_question/presentation/views/upeq_screen.dart';
import 'package:ited_study_app_admin/feature/admin/upload_past_test_question/presentation/views/uptq_screen.dart';
import '../../../../core/constants/style.dart';
import '../../../../core/provider/providers.dart';

class Dashboard extends ConsumerWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seletedIndex = ref.watch(screenProvider);
    List<Widget> pages = [
      UploadCourseScreen(),
      UploadNoteScreen(),
      UploadPastTestQuestionScreen(),
      UploadPastExamQuestionScreen(),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: 246,
            color: Color.fromRGBO(0, 5, 45, 1),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            textAlign: TextAlign.left,
                            "Profile",
                            style: CustomStyle.tittleStyle,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Building our generation together",
                            style: CustomStyle.subTittleStyle,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          CustomBoxSize.extra,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              textAlign: TextAlign.left,
                              "Overview",
                              style: CustomStyle.otherStyle,
                            ),
                          ),
                          CustomBoxSize.medium,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Order History",
                              style: CustomStyle.otherStyle,
                            ),
                          ),
                          CustomBoxSize.medium,
                          InkWell(
                            onTap: () {
                              // context.push(AdminRoutes.uploadcourse);
                              ref.read(screenProvider.notifier).state = 0;
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Upload Courses",
                                style: CustomStyle.otherStyle,
                              ),
                            ),
                          ),
                          // CustomBoxSize.medium,
                          // InkWell(
                          //   onTap: () {
                          //     // context.push(AdminRoutes.uploadnote);
                          //     ref.read(screenProvider.notifier).state = 1;
                          //   },
                          //   child: Align(
                          //     alignment: Alignment.centerLeft,
                          //     child: Text(
                          //       "Upload Notes",
                          //       style: CustomStyle.otherStyle,
                          //     ),
                          //   ),
                          // ),
                          CustomBoxSize.medium,
                          InkWell(
                            onTap: () {
                              // context.push(AdminRoutes.uploadptq);
                              ref.read(screenProvider.notifier).state = 2;
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Upload Past Test Questions",
                                style: CustomStyle.otherStyle,
                              ),
                            ),
                          ),
                          CustomBoxSize.medium,
                          InkWell(
                            onTap: () {
                              ref.read(screenProvider.notifier).state = 3;
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Upload Past Exam Questions",
                                style: CustomStyle.otherStyle,
                              ),
                            ),
                          ),
                          CustomBoxSize.medium,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Notifications",
                              style: CustomStyle.otherStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          CustomBoxSize.xxLarge,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Help Center",
                              style: CustomStyle.otherStyle,
                            ),
                          ),
                          CustomBoxSize.medium,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Contact Us",
                              style: CustomStyle.otherStyle,
                            ),
                          ),
                          CustomBoxSize.medium,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                "Logout",
                                style: CustomStyle.otherStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Welcome back, Daniel",
                          style: CustomStyle.name,
                        ),
                        Container(
                          width: 50,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.notifications),
                        )
                      ],
                    ),
                  ),
                ),
                // Divider(
                //   thickness: 1,
                // ),
                Expanded(
                  child: pages[seletedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
