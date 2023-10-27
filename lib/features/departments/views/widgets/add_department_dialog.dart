import 'package:emplman/core/constants.dart';
import 'package:emplman/features/departments/models/department.dart';
import 'package:emplman/features/departments/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddOrEditDepartmentDialog extends ConsumerStatefulWidget {
  const AddOrEditDepartmentDialog({super.key, this.department});

  final Department? department;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddDepartmentDialogState();
}

class _AddDepartmentDialogState
    extends ConsumerState<AddOrEditDepartmentDialog> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.department?.name);
  }

  void onpressed() async {
    if (formKey.currentState!.validate()) {
      final dept = Department(
        id: widget.department?.id,
        name: _nameController.text,
      );
      if (widget.department == null) {
        await ref
            .read(departmentsControllerProvider.notifier)
            .createDepartment(dept);
      } else {
        await ref
            .read(departmentsControllerProvider.notifier)
            .updateDepartment(dept);
      }
      ref.refresh(getDepartmentsProvider);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(departmentsControllerProvider);
    final dept = widget.department;

    return AlertDialog(
      title: Text("${dept == null ? 'Add' : 'Edit'} Department"),
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
