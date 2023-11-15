import 'package:codexia_e_learning/course/service/course_service.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier{
  CourseService courseService;

  CourseProvider(this.courseService);
}

