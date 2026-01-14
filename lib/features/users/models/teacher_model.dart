class TeacherModel {
  final String teacherId;
  final String name;
  final String department;
  final List<String> classAssigned;
  final String phone;
  final String address;
  final String? profileImageBase64;
  final String password;
  final bool isPassChanged;
  final String status;

  TeacherModel({
    required this.teacherId,
    required this.name,
    required this.department,
    required this.classAssigned,
    required this.phone,
    required this.address,
    required this.profileImageBase64,
    required this.password,
    required this.isPassChanged,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
    'teacherId': teacherId,
    'name': name,
    'department': department,
    'classAssigned': classAssigned,
    'phone': phone,
    'address': address,
    'profileImageBase64': profileImageBase64,
    'password': password,
    'isPassChanged': isPassChanged,
    'status': status,
  };
}
