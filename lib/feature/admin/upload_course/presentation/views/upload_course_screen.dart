// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ited_study_app_admin/core/route/routes.dart';

import '../../../../../core/constants/style.dart';
import '../../../../../core/provider/providers.dart';
import '../../../../../core/widgets/upload.dart';
import '../../widgets/custom_list_tile.dart';

class UploadCourseScreen extends ConsumerStatefulWidget {
  const UploadCourseScreen({super.key});

  @override
  ConsumerState<UploadCourseScreen> createState() => UploadCourseScreenState();
}

class UploadCourseScreenState extends ConsumerState<UploadCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Upload Course"),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => UploadCourse(),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: GridView.builder(
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 1,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      print("tapped");
                      // context.push(AdminRoutes.uploadnote);
                      ref.read(screenProvider.notifier).state = 1;
                    },
                    onLongPress: () {
                      print("long pressed");
                      context.push(AdminRoutes.uploadpeq);
                    },
                    child: CustomListTile(
                      leading: Image.asset(
                        "assets/images/chem.png",
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Course Title",
                            style: CustomStyle.secondtinyBody,
                          ),
                          Text(
                            "Mathematics",
                            style: CustomStyle.mediumSubtitleText,
                          ),
                          Text(
                            "Course Code",
                            style: CustomStyle.secondtinyBody,
                          ),
                          Text(
                            "Maths 101",
                            style: CustomStyle.mediumSubtitleText,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
