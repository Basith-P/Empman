import 'package:emplman/features/departments/providers.dart';
import 'package:emplman/features/departments/views/widgets/add_department_dialog.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepartmentsList extends ConsumerWidget {
  const DepartmentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isLoading = ref.watch(getDepartmentsProvider).isLoading;

    return ref.watch(getDepartmentsProvider).when(
          data: (data) => data.isEmpty
              ? const Center(child: Text("No departments found"))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                        title: Text(data[i].name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(FluentIcons.edit_16_regular),
                              onPressed: isLoading
                                  ? null
                                  : () => showDialog(
                                      context: context,
                                      builder: (_) => AddOrEditDepartmentDialog(
                                          department: data[i])),
                            ),
                            IconButton(
                              icon: const Icon(FluentIcons.delete_16_regular),
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      await ref
                                          .read(departmentsControllerProvider
                                              .notifier)
                                          .deleteDepartment(data[i]);
                                      ref.refresh(getDepartmentsProvider);
                                    },
                            ),
                          ],
                        ));
                  },
                ),
          error: (e, st) => const Center(child: Text('Something went wrong')),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
