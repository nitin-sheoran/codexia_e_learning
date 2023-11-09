import 'package:firebase_database/firebase_database.dart';

class QuizService {
  Stream<DatabaseEvent> getQuestionStream(String chapterId) {
    return FirebaseDatabase.instance.ref('quiz').child(chapterId).onValue;
  }
}
