import 'package:codexia_e_learning/quiz/service/quiz_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class QuizProvider extends ChangeNotifier{
  QuizService quizService;

  QuizProvider(this.quizService);

  Stream<DatabaseEvent> getQuestionStream(String chapterId) {
    return quizService.getQuestionStream(chapterId);
  }
}
