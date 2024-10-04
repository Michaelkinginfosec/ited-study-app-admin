import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import '../../../../../core/constants/style.dart';
import '../../../../../core/provider/providers.dart';
import '../../domain/entities/course_entity.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/upload_country.dart';
import '../../widgets/upload_school.dart';
import '../../widgets/upload_course.dart';

class UploadCourseScreen extends ConsumerStatefulWidget {
  const UploadCourseScreen({super.key});

  @override
  ConsumerState<UploadCourseScreen> createState() => UploadCourseScreenState();
}

class UploadCourseScreenState extends ConsumerState<UploadCourseScreen> {
  List<CourseEntity> _courses = [];

  @override
  void initState() {
    super.initState();
    // Fetch the courses and update the state when complete
    fetchCourse();
  }

  Future<void> fetchCourse() async {
    var box = Hive.box<CourseEntity>('courses');
    List<CourseEntity> courses = box.values.toList();
    setState(() {
      _courses = courses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text("Add University"),
                      IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return UploadSchool();
                              });
                        },
                        icon: Icon(Icons.add),
                      ),
                      Text("Add Country"),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => UploadCountry(),
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Upload Course"),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (context) => UploadCourse(),
                          );
                        },
                        icon: Icon(Icons.add),
                      ),
                    ],
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
                itemCount: _courses.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 4 / 1,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      ref.read(screenProvider.notifier).state = 1;
                    },
                    child: CustomListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          _courses[index].courseImage,
                          width: 100,
                          height: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Course Name",
                            style: CustomStyle.secondtinyBody,
                          ),
                          Text(
                            _courses[index].courseName,
                            style: CustomStyle.mediumSubtitleText,
                          ),
                          Text(
                            "Course Code",
                            style: CustomStyle.secondtinyBody,
                          ),
                          Text(
                            _courses[index].courseCode,
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
