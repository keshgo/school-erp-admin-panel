import 'package:admin_panel/features/users/models/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod/legacy.dart';

final studentFormProvider =
    StateNotifierProvider<StudentFromNotifier, StudentFormState>(
      (ref) => StudentFromNotifier(),
    );

class StudentFormState {
  final String name;
  final SchoolClass? schoolClass;
  final Section? section;
  final House? house;
  final String phone;
  final String mother;
  final String father;
  final String address;
  final String profileImage64;

  StudentFormState({
    this.name = "",
    this.schoolClass,
    this.section,
    this.house,
    this.phone = "",
    this.mother = "",
    this.father = "",
    this.address = "",
    this.profileImage64 = "",
  });

 bool get isValid {
  return name.trim().isNotEmpty &&
      schoolClass != null &&
      section != null &&
      house != null &&
      phone.length == 10 &&
      mother.trim().isNotEmpty &&
      father.trim().isNotEmpty &&
      address.trim().isNotEmpty &&
      profileImage64.isNotEmpty;
}


  StudentFormState copyWith({
    String? name,
    SchoolClass? schoolClass,
    Section? section,
    House? house,
    String? phone,
    String? mother,
    String? father,
    String? address,
    String? profileImage64,
  }) {
    return StudentFormState(
      name: name ?? this.name,
      schoolClass: schoolClass ?? this.schoolClass,
      section: section ?? this.section,
      house: house ?? this.house,
      phone: phone ?? this.phone,
      mother: mother ?? this.mother,
      father: father ?? this.father,
      address: address ?? this.address,
      profileImage64: profileImage64 ?? this.profileImage64,
    );
  }
}

class StudentFromNotifier extends StateNotifier<StudentFormState> {
  StudentFromNotifier() : super(StudentFormState());

  void setName(String val) => state = state.copyWith(name: val);
  void setClass(SchoolClass val) => state = state.copyWith(schoolClass: val);
  void setSection(Section val) => state = state.copyWith(section: val);
  void setHouse(House val) => state = state.copyWith(house: val);
  void setPhone(String val) => state = state.copyWith(phone: val);
  void setMother(String val) => state = state.copyWith(mother: val);
  void setFather(String val) => state = state.copyWith(father: val);
  void setAddress(String val) => state = state.copyWith(address: val);
  void setProfileImage(String val) {
    debugPrint("SAVING IMAGE IN PROVIDER: ${val.length}");
    state = state.copyWith(profileImage64: val);
  }
}
