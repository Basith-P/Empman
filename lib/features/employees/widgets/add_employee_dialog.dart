import 'package:emplman/core/constants.dart';
import 'package:emplman/features/employees/models/employee.dart';
import 'package:emplman/features/employees/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEmployeeDialog extends ConsumerStatefulWidget {
  const AddEmployeeDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddEmployeeDialogState();
}

class _AddEmployeeDialogState extends ConsumerState<AddEmployeeDialog> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dateOfJoiningController;

  DateTime? _dateOfJoining = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _dateOfJoiningController =
        TextEditingController(text: DateFormat.yMd().format(DateTime.now()));
  }

  void onpressed() async {
    if (formKey.currentState!.validate()) {
      final employee = Employee(
        name: _nameController.text,
        email: _emailController.text,
        joiningDate: _dateOfJoiningController.text,
      );
      ref
          .read(employeesControllerProvider.notifier)
          .createEmployee(employee)
          .then((value) {
        if (value) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(employeesControllerProvider);

    return AlertDialog(
      title: const Text("Add Employee"),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: kinputDecoration.copyWith(labelText: "Name"),
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a name";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: kinputDecoration.copyWith(labelText: "Email"),
              enabled: !isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter an email";
                }
                return null;
              },
            ),
            TextFormField(
              decoration:
                  kinputDecoration.copyWith(labelText: "Date of Joining"),
              enabled: !isLoading,
              readOnly: true,
              controller: _dateOfJoiningController,
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (date != null) {
                  setState(() {
                    _dateOfJoining = date;
                    _dateOfJoiningController.text =
                        DateFormat.yMd().format(_dateOfJoining!);
                  });
                }
              },
            )
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
    _emailController.dispose();
    _dateOfJoiningController.dispose();
    super.dispose();
  }
}
