import 'package:firebase_database/firebase_database.dart';

class CourseService {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref().child(
      "courses");

  Stream<DatabaseEvent> getCourseStream() {
    return databaseRef.onValue;
  }
}