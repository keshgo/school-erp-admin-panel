class StudentModel {
  final String studentId;
  final String name;
  final String classId;
  final String section;
  final String house;
  final String phone;
  final String motherName;
  final String fatherName;
  final String address;
  // final String profilePicUrl;
  final String password;
  final bool isPassChanged;
  final String status;
  final String profileImage64;

  StudentModel({
    required this.studentId,
    required this.name,
    required this.classId,
    required this.section,
    required this.house,
    required this.phone,
    required this.motherName,
    required this.fatherName,
    required this.address,
    // required this.profilePicUrl,
    required this.password,
    required this.isPassChanged,
    required this.status,
    required this.profileImage64,
  });

  Map<String, dynamic> toJson() => {
    'studentId': studentId,
    'name': name,
    'class': classId,
    'section': section,
    'house': house,
    'phone': phone,
    'motherName': motherName,
    'fatherName': fatherName,
    'address': address,
    // 'profilePic': profilePicUrl,
    'password': password,
    'isPassChanged': isPassChanged,
    'status': status,
    'profileImageBase64': profileImage64,
  };
}
