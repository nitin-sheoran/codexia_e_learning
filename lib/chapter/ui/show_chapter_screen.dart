import 'package:flutter/material.dart';
import 'package:codexia_e_learning/chapter/model/chapter_model.dart';
import 'package:codexia_e_learning/chapter/service/chapter_service.dart';
import 'package:codexia_e_learning/chapter/ui/content_detail_screen.dart';
import 'package:codexia_e_learning/course/model/course_model.dart';
import 'package:codexia_e_learning/shared/colors_const.dart';
import 'package:codexia_e_learning/shared/string_const.dart';
import 'package:firebase_database/firebase_database.dart';

class ShowChapterScreen extends StatefulWidget {
  final ChapterService chapterService;
  final String courseId;
  final Course course;

  const ShowChapterScreen({
    required this.course,
    required this.chapterService,
    required this.courseId,
    super.key,
  });

  @override
  _ShowChapterScreenState createState() => _ShowChapterScreenState();
}

class _ShowChapterScreenState extends State<ShowChapterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              widget.course.courseName,
              style: const TextStyle(
                color: ColorsConst.whiteColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              StringConst.showChapterScreenText,
              style: TextStyle(
                color: ColorsConst.whiteColor,
              ),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: ColorsConst.whiteColor,
          ),
        ),
        backgroundColor: ColorsConst.blueColor,
      ),
      body: StreamBuilder(
        stream: widget.chapterService.getChapterStream(widget.courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Chapter> chapterList = [];
            DataSnapshot dataSnapshot = snapshot.data!.snapshot;
            if (dataSnapshot.exists) {
              final map = dataSnapshot.value as Map<String, dynamic>;

              map.forEach(
                (key, value) {
                  var chapter = Chapter(
                    id: value[StringConst.id] ?? '',
                    courseId: value[StringConst.courseId] ?? '',
                    chapterName: value[StringConst.chapterName] ?? '',
                    content: value[StringConst.content] ?? '',
                  );
                  chapterList.add(chapter);
                },
              );
            }
            return ListView.builder(
              itemCount: chapterList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContentDetailScreen(
                          chapter: chapterList[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: ColorsConst.whiteColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 20,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chapterList[index].chapterName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(color: ColorsConst.black12Color),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
