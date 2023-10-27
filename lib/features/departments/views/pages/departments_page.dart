import 'package:emplman/features/departments/views/widgets/add_department_dialog.dart';
import 'package:emplman/features/departments/views/widgets/dapartments_list.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class DepartmentsListPage extends StatelessWidget {
  const DepartmentsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const DepartmentsList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
            context: context, builder: (_) => const AddDepartmentDialog()),
        child: const Icon(FluentIcons.add_24_regular),
      ),
    );
  }
}
