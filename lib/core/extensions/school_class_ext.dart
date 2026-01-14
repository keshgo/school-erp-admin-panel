import 'package:admin_panel/features/users/models/enums.dart';

extension SchoolClassX on SchoolClass {
  String get label {
    switch (this) {
      case SchoolClass.first:
        return "1";
      case SchoolClass.second:
        return "2";
      case SchoolClass.third:
        return "3";
      case SchoolClass.fourth:
        return "4";
      case SchoolClass.fifth:
        return "5";
      case SchoolClass.sixth:
        return "6";
      case SchoolClass.seventh:
        return "7";
      case SchoolClass.eight:
        return "8";
      case SchoolClass.nineth:
        return "9";
      case SchoolClass.tenth:
        return "10";
      case SchoolClass.eleventh:
        return "11";
      case SchoolClass.twelveth:
        return "12";
    }
  }
}

extension SectionX on Section {
  String get label {
    switch (this) {
      case Section.A:
        return "A";
      case Section.B:
        return "B";
      case Section.C:
        return "C";
      case Section.D:
        return "D";
    }
  }
}
