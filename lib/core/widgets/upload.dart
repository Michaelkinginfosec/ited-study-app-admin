// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ited_study_app_admin/core/constants/boxsize.dart';
import 'package:ited_study_app_admin/core/constants/style.dart';
import 'package:ited_study_app_admin/core/widgets/form_field.dart';

class UploadCourse extends StatefulWidget {
  const UploadCourse({super.key});

  @override
  State<UploadCourse> createState() => _UploadCourseState();
}

class _UploadCourseState extends State<UploadCourse> {
  final TextEditingController coutryController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController courseTittleController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 450, vertical: 80),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(189, 193, 200, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Upload Course",
                style: CustomStyle.mediumSubtitleText,
              ),
              CustomBoxSize.big,
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Column(
                    children: [
                      CustomFormField(
                        label: "Country",
                        controller: coutryController,
                        keyboardType: TextInputType.name,
                        obscure: isObscure,
                      ),
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "School Name",
                        obscure: isObscure,
                        controller: schoolController,
                        keyboardType: TextInputType.name,
                      ),
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "Course Title",
                        obscure: isObscure,
                        controller: courseTittleController,
                        keyboardType: TextInputType.name,
                      ),
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "Course Code",
                        obscure: isObscure,
                        controller: courseCodeController,
                        keyboardType: TextInputType.name,
                      ),
                    ],
                  ),
                ),
              ),
              CustomBoxSize.big,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(0, 16, 147, 1),
                        Color.fromRGBO(0, 5, 45, 1),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Add Course",
                      style: CustomStyle.loginStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
