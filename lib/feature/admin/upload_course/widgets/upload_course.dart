import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:ited_study_app_admin/core/constants/boxsize.dart';
import 'package:ited_study_app_admin/core/constants/style.dart';
import 'package:ited_study_app_admin/core/widgets/form_field.dart';
import 'package:ited_study_app_admin/feature/admin/upload_course/presentation/provider/create_course_provider.dart';

class UploadCourse extends ConsumerStatefulWidget {
  const UploadCourse({super.key});

  @override
  ConsumerState<UploadCourse> createState() => UploadCourseState();
}

class UploadCourseState extends ConsumerState<UploadCourse> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseTittleController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isObscure = false;

  File? imageFile;

  Uint8List? imageBytes;
  String? selectedSchool;
  List<String> schoolNames = [];

  @override
  void initState() {
    super.initState();
    _loadSchoolList();
  }

  Future<void> _loadSchoolList() async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentSchoolList =
        (box.get('schoolList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();

    setState(() {
      schoolNames =
          currentSchoolList.map((school) => school.keys.first).toList();
    });
  }

  Future<String?> getSchoolIdByName(String schoolName) async {
    var box = Hive.box('notes');

    List<Map<String, String>> currentSchoolList =
        (box.get('schoolList', defaultValue: []) as List)
            .map((e) => Map<String, String>.from(e))
            .toList();

    for (var school in currentSchoolList) {
      if (school.containsKey(schoolName)) {
        return school[schoolName];
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final createCourseState = ref.watch(createCourseNotifierProvider);
    ref.listen(
      createCourseNotifierProvider,
      (previous, next) {
        if (next.status == CreateCourseStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message ?? "Course Created Successfully"),
            ),
          );
        } else if (next.status == CreateCourseStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error ?? "Error"),
            ),
          );
        }
      },
    );

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
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          label: Text("School"),
                          hintStyle: const TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 10,
                          ),
                          contentPadding: const EdgeInsets.only(left: 20),
                          hintText: 'Select School',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(0, 5, 45, 1),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(0, 5, 45, 1),
                              width: 1,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(0, 5, 45, 1),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(0, 5, 45, 1),
                              width: 1,
                            ),
                          ),
                          enabled: true,
                        ),
                        hint: Text('Select a School'),
                        value: selectedSchool,
                        items: schoolNames.map((String schoolName) {
                          return DropdownMenuItem<String>(
                            value: schoolName,
                            child: Text(schoolName),
                          );
                        }).toList(),
                        onChanged: (String? newSchool) async {
                          setState(() {
                            selectedSchool = newSchool;
                          });
                        },
                      ),
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "Course Name",
                        obscure: isObscure,
                        controller: courseNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Course Name";
                          }
                          return null;
                        },
                      ),
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "Course Title",
                        obscure: isObscure,
                        controller: courseTittleController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Course Tittle";
                          }
                          return null;
                        },
                      ),
                      CustomBoxSize.medium,
                      CustomFormField(
                        label: "Course Code",
                        obscure: isObscure,
                        controller: courseCodeController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Course Code";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CustomBoxSize.big,
              createCourseState.status == CreateCourseStatus.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: InkWell(
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            Uint8List? imageBytes =
                                await _pickImage(ImageSource.gallery);

                            if (imageBytes != null) {
                              if (courseCodeController.text.isEmpty ||
                                  courseNameController.text.isEmpty ||
                                  courseTittleController.text.isEmpty) {
                                throw Exception("Please fill all fields");
                              }

                              ref
                                  .read(createCourseNotifierProvider.notifier)
                                  .createCourse(
                                    selectedSchool!,
                                    courseNameController.text,
                                    courseTittleController.text,
                                    courseCodeController.text,
                                    imageBytes,
                                  );
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> _pickImage(ImageSource source) async {
    if (kIsWeb) {
      final pickedFile = await ImagePickerWeb.getImageAsBytes();
      if (pickedFile != null) {
        return pickedFile;
      }
    } else {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        return bytes;
      }
    }
    return null;
  }
}
