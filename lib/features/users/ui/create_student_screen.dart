import 'dart:convert';
// import 'dart:io';

import 'package:admin_panel/features/users/models/enums.dart';
import 'package:admin_panel/features/users/models/student_model.dart';
import 'package:admin_panel/features/users/providers/student_form_provider.dart';
import 'package:admin_panel/features/users/services/id_generator.dart';
import 'package:admin_panel/features/users/services/password_generator.dart';
import 'package:admin_panel/features/users/services/user_service.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateStudentScreen extends ConsumerWidget {
  const CreateStudentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(studentFormProvider);
    final notifier = ref.read(studentFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Create Student")),
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
            DropdownButtonFormField<SchoolClass>(
              decoration: const InputDecoration(labelText: "Class"),
              initialValue: form.schoolClass,
              items: SchoolClass.values.map((c) {
                return DropdownMenuItem(value: c, child: Text(c.name));
              }).toList(),
              onChanged: (value) => notifier.setClass(value!),
            ),
            DropdownButtonFormField<Section>(
              decoration: const InputDecoration(labelText: "Section"),
              initialValue: form.section,
              items: Section.values.map((c) {
                return DropdownMenuItem(value: c, child: Text(c.name));
              }).toList(),
              onChanged: (value) => notifier.setSection(value!),
            ),
            DropdownButtonFormField<House>(
              decoration: const InputDecoration(labelText: "House"),
              initialValue: form.house,
              items: House.values.map((c) {
                return DropdownMenuItem(value: c, child: Text(c.name));
              }).toList(),
              onChanged: (value) => notifier.setHouse(value!),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Phone Number",
                errorText: form.phone.isEmpty
                    ? null
                    : (form.phone.length != 10
                          ? "Enter 10 digit number"
                          : null),
              ),
              keyboardType: TextInputType.phone,
              onChanged: notifier.setPhone,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Father's Name",
                errorText: form.address.isEmpty ? "Father's Name Required" : null,
              ),
              onChanged: notifier.setFather,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Mother's Name",
                errorText: form.address.isEmpty ? "Mother's Name Required" : null,
              ),
              onChanged: notifier.setMother,
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
                      .read(studentFormProvider.notifier)
                      .setProfileImage(base64);
                }
              },
            ),
            Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Name: ${form.name.isNotEmpty}"),
    Text("Class: ${form.schoolClass != null}"),
    Text("Section: ${form.section != null}"),
    Text("House: ${form.house != null}"),
    Text("Phone(10): ${form.phone.length == 10}"),
    Text("Mother: ${form.mother.isNotEmpty}"),
    Text("Father: ${form.father.isNotEmpty}"),
    Text("Address: ${form.address.isNotEmpty}"),
    Text("Image: ${form.profileImage64.isNotEmpty}"),
    const Divider(),
    Text("FORM VALID = ${form.isValid}", style: TextStyle(fontWeight: FontWeight.bold)),
  ],
),

            ElevatedButton(
              child: const Text("Create Student"),
              onPressed: form.isValid
                  ? () async {
                      final form = ref.read(studentFormProvider);
                      debugPrint(
                        "FINAL IMAGE LENGTH: ${form.profileImage64.length}",
                      );
                      final service = UserService();

                      final count = await service.getStudentCount();

                      final studentId = IdGenerator.genenrateStudentId(
                        year: DateTime.now().year,
                        classId: form.schoolClass!.name,
                        section: form.section!.name,
                        index: count,
                      );

                      final password = PasswordGenerator.generate();

                      final student = StudentModel(
                        studentId: studentId,
                        name: form.name,
                        classId: form.schoolClass!.name,
                        section: form.section!.name,
                        house: form.house!.name,
                        phone: form.phone,
                        motherName: form.mother,
                        fatherName: form.father,
                        address: form.address,
                        // profilePicUrl: '',
                        password: password,
                        isPassChanged: false,
                        status: 'Active',
                        profileImage64: form.profileImage64,
                      );

                      await service.createStudent(student);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Student Created: $studentId")),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
