import 'package:admin_panel/features/users/models/student_model.dart';
import 'package:admin_panel/features/users/models/teacher_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Future<int> getStudentCount() async {
    final snap = await _db.collection('student').get();
    return snap.docs.length + 1;
  }

  Future<void> createStudent(StudentModel student) async {
    await _db
        .collection('student')
        .doc(student.studentId)
        .set(student.toJson());
  }

  Future<int> getTeacherCount() async {
    final snap = await _db.collection('teacher').get();
    return snap.docs.length + 1;
  }

  Future<void> createTeacher(TeacherModel teacher) async {
    await _db
        .collection('teacher')
        .doc(teacher.teacherId)
        .set(teacher.toJson());
  }
}
