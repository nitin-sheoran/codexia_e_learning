import 'package:firebase_database/firebase_database.dart';

class ChapterService {
  Stream<DatabaseEvent> getChapterStream(String courseId) {
    return FirebaseDatabase.instance.ref('chapter').child(courseId).onValue;
  }
}
