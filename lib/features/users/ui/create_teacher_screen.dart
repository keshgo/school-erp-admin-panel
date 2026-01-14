import 'dart:convert';

import 'package:admin_panel/core/extensions/school_class_ext.dart';
import 'package:admin_panel/features/users/models/enums.dart';
import 'package:admin_panel/features/users/models/teacher_model.dart';
import 'package:admin_panel/features/users/providers/teacher_form_provider.dart';
import 'package:admin_panel/features/users/services/id_generator.dart';
import 'package:admin_panel/features/users/services/password_generator.dart';
import 'package:admin_panel/features/users/services/user_service.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateTeacherScreen extends ConsumerWidget {
  const CreateTeacherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(teacherFormProvider);
    final notifier = ref.read(teacherFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Teacher")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                errorText: form.name.isEmpty ? "Name Required" : null,
              ),
              onChanged: notifier.setName,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<SchoolClass>(
                    initialValue: form.selectedClass,
                    hint: const Text("Class"),
                    items: SchoolClass.values.map((cls) {
                      return DropdownMenuItem(
                        value: cls,
                        child: Text(cls.label),
                      );
                    }).toList(),
                    onChanged: (value) => notifier.setSelectedClass(value),
                  ),
                ),
                const SizedBox(width: 10),

                Expanded(
                  child: DropdownButtonFormField<Section>(
                    initialValue: form.selectedSection,
                    hint: const Text("Section"),
                    items: Section.values.map((sec) {
                      return DropdownMenuItem(
                        value: sec,
                        child: Text(sec.label),
                      );
                    }).toList(),
                    onChanged: notifier.setSelectedSection,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    if (form.selectedClass == null ||
                        form.selectedSection == null) {
                      return;
                    }
                    final cls =
                        "${form.selectedClass!.label}-${form.selectedSection!.label}";

                    notifier.addClass(cls);
                  },
                  icon: const Icon(Icons.add_circle),
                ),
                Wrap(
                  spacing: 8,
                  children: form.assignedClasses
                      .map(
                        (e) => Chip(
                          label: Text(e),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () => notifier.removeClass(e),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
            DropdownButtonFormField<Department>(
              decoration: const InputDecoration(labelText: "Class"),
              initialValue: form.department,
              items: Department.values.map((c) {
                return DropdownMenuItem(value: c, child: Text(c.name));
              }).toList(),
              onChanged: (value) => notifier.setDepartment(value!),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Phone",
                errorText: form.phone.isEmpty ? "Phone Required" : null,
              ),
              onChanged: notifier.setPhone,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Address",
                errorText: form.address.isEmpty ? "Address Required" : null,
              ),
              onChanged: notifier.setAddress,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add_a_photo),
              label: const Text("Pick Photo"),
              onPressed: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (picked != null) {
                  final bytes = await picked.readAsBytes();
                  final base64 = base64Encode(bytes);

                  debugPrint("IMAGE BASE64 LENGTH: ${base64.length}");

                  ref
                      .read(teacherFormProvider.notifier)
                      .setProfileBase64(base64);
                }
              },
            ),
            ElevatedButton(
              onPressed: form.isValid
                  ? () async {
                      final form = ref.read(teacherFormProvider);

                      final service = UserService();

                      final count = await service.getTeacherCount();

                      final teacherId = IdGenerator.generateTeacherId(count);

                      final password = PasswordGenerator.generate();

                      final teacher = TeacherModel(
                        teacherId: teacherId,
                        name: form.name,
                        department: form.department!.name,
                        classAssigned: form.assignedClasses,
                        phone: form.phone,
                        address: form.address,
                        profileImageBase64: form.profileImageBase64,
                        password: password,
                        isPassChanged: false,
                        status: 'Active',
                      );

                      await service.createTeacher(teacher);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Teacher Created: $teacherId")),
                      );
                    }
                  : null,
              child: const Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
