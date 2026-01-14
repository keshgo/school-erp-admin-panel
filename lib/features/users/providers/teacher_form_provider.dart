import 'package:admin_panel/features/users/models/enums.dart';
import 'package:flutter_riverpod/legacy.dart';

final teacherFormProvider =
    StateNotifierProvider<TeacherFormNotifier, TeacherFormState>(
      (ref) => TeacherFormNotifier(),
    );

class TeacherFormState {
  final String name;
  final Department? department;
  final List<String> assignedClasses;
  final String phone;
  final String address;
  final String? profileImageBase64;
  final SchoolClass? selectedClass;
  final Section? selectedSection;

  TeacherFormState({
    this.name = '',
    this.department,
    this.assignedClasses = const [],
    this.phone = '',
    this.address = '',
    this.profileImageBase64,
    this.selectedClass,
    this.selectedSection,
  });

  TeacherFormState copyWith({
    String? name,
    Department? department,
    List<String>? assignedClasses,
    String? phone,
    String? address,
    String? profileImageBase64,
    SchoolClass? selectedClass,
    Section? selectedSection,
  }) {
    return TeacherFormState(
      name: name ?? this.name,
      department: department ?? this.department,
      assignedClasses: assignedClasses ?? this.assignedClasses,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      profileImageBase64: profileImageBase64 ?? this.profileImageBase64,
      selectedClass: selectedClass ?? this.selectedClass,
      selectedSection: selectedSection ?? this.selectedSection,
    );
  }

  bool get isValid =>
      name.isNotEmpty &&
      department != null &&
      assignedClasses.isNotEmpty &&
      phone.length == 10 &&
      address.isNotEmpty;
}

class TeacherFormNotifier extends StateNotifier<TeacherFormState> {
  TeacherFormNotifier() : super(TeacherFormState());

  void setName(String v) => state = state.copyWith(name: v);
  void setDepartment(Department v) => state = state.copyWith(department: v);
  void setPhone(String v) => state = state.copyWith(phone: v);
  void setAddress(String v) => state = state.copyWith(address: v);
  void setProfileBase64(String v) =>
      state = state.copyWith(profileImageBase64: v);
  void setSelectedClass(SchoolClass? value) {
    state = state.copyWith(selectedClass: value);
  }

  void setSelectedSection(Section? value) {
    state = state.copyWith(selectedSection: value);
  }

  void addClass(String cls) {
    final updated = [...state.assignedClasses, cls];
    state = state.copyWith(assignedClasses: updated);
  }

  void removeClass(String cls) {
    final updated = state.assignedClasses.where((c) => c != cls).toList();
    state = state.copyWith(assignedClasses: updated);
  }
}
