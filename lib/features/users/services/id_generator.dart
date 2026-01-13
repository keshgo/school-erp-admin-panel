class IdGenerator {
  static String genenrateStudentId({
    required int year,
    required String classId,
    required String section,
    required int index,
  }) {
    return "STU-$year-$classId$section-$index";
  }

  static String generateTeacherId(int index) {
    return "TCH-${index.toString().padLeft(4, '0')}";
  }
}
