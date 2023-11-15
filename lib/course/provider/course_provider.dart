import 'package:codexia_e_learning/course/service/course_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier{
  CourseService courseService;

  CourseProvider(this.courseService);

  Stream<DatabaseEvent> listenCourse() {
    return courseService.getCourseStream();
  }
}

