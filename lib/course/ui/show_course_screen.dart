import 'package:flutter/material.dart';
import 'package:codexia_e_learning/shared/app_const.dart';
import 'package:codexia_e_learning/shared/colors_const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:codexia_e_learning/course/model/course_model.dart';
import 'package:codexia_e_learning/chapter/service/chapter_service.dart';
import 'package:codexia_e_learning/chapter/ui/show_chapter_screen.dart';
import 'package:codexia_e_learning/course/service/course_service.dart';

class ShowCourseScreen extends StatefulWidget {
  final CourseService courseService;

  const ShowCourseScreen({required this.courseService, super.key});

  @override
  _ShowCourseScreenState createState() => _ShowCourseScreenState();
}

class _ShowCourseScreenState extends State<ShowCourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConst.titleText2,
          style: TextStyle(
            color: ColorsConst.whiteColor,
            fontSize: 26,
          ),
        ),
        backgroundColor: ColorsConst.blueColor,
      ),
      body: StreamBuilder(
        stream: widget.courseService.getCourseStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Course> courseList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            final map = dataSnapshot.value as Map<dynamic, dynamic>;
            forEach(map, courseList);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  mainAxisExtent: 200,
                ),
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowChapterScreen(
                            course: courseList[index],
                            chapterService: ChapterService(),
                            courseId: courseList[index].courseId!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      surfaceTintColor: ColorsConst.whiteColor,
                      color: ColorsConst.whiteColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (courseList[index].imgUrl.isNotEmpty)
                            Image.network(
                              courseList[index].imgUrl,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          Text(
                            courseList[index].courseName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void forEach(Map<dynamic, dynamic> map, List<Course> courseList) {
    map.forEach((key, value) {
      if (value != null) {
        var course = Course(
          courseId: key,
          courseName: value['courseName'] ?? '',
          imgUrl: value['imgUrl'] ?? '',
        );
        courseList.add(course);
      }
    });
  }
}
