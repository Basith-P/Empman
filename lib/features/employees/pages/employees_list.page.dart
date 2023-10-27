import 'package:emplman/features/employees/widgets/add_employee_dialog.dart';
import 'package:emplman/features/employees/widgets/employees_list.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class EmployeesListPage extends StatelessWidget {
  const EmployeesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const EmployeesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (_) => const AddEmployeeDialog()),
        child: const Icon(FluentIcons.person_add_24_regular),
      ),
    );
  }
}
