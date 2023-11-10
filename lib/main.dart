import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:codexia_e_learning/firebase_options.dart';
import 'package:codexia_e_learning/course/service/course_service.dart';
import 'package:codexia_e_learning/course/ui/show_course_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Codexia Academy',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ShowCourseScreen(
        courseService: CourseService(),
      ),
    );
  }
}

