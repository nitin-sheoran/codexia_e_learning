import 'package:codexia_e_learning/screens/navigation_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:codexia_e_learning/firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:codexia_e_learning/quiz/service/quiz_service.dart';
import 'package:codexia_e_learning/login/ui/auth_login_screen.dart';
import 'package:codexia_e_learning/quiz/provider/quiz_provider.dart';
import 'package:codexia_e_learning/course/service/course_service.dart';
import 'package:codexia_e_learning/chapter/service/chapter_service.dart';
import 'package:codexia_e_learning/course/provider/course_provider.dart';
import 'package:codexia_e_learning/chapter/provider/chapter_provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'Codexia Academy',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const fatalError = true;
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    }
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    } else {}
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CourseProvider(CourseService())),
        ChangeNotifierProvider(create: (context) => ChapterProvider(ChapterService())),
        ChangeNotifierProvider(create: (context) => QuizProvider(QuizService())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NavigationBarScreen(),
      ),
    );
  }
}
