import 'package:emplman/core/constants.dart';
import 'package:emplman/features/departments/models/department.dart';
import 'package:emplman/features/departments/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddDepartmentDialog extends ConsumerStatefulWidget {
  const AddDepartmentDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddDepartmentDialogState();
}

class _AddDepartmentDialogState extends ConsumerState<AddDepartmentDialog> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  void onpressed() {
    if (formKey.currentState!.validate()) {
      final department = Department(name: _nameController.text);
      ref
          .read(departmentsControllerProvider.notifier)
          .createDepartment(department)
          .then((value) {
        if (value) {
          Navigator.pop(context);
          ref.refresh(getDepartmentsProvider);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(departmentsControllerProvider);

    return AlertDialog(
      title: const Text("Add Department"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: kinputDecoration.copyWith(labelText: "Name"),
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a name";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: isLoading
          ? const [
              Center(child: CircularProgressIndicator()),
            ]
          : [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: onpressed,
                child: const Text("Add"),
              ),
            ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
