import 'package:emplman/features/departments/providers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepartmentsList extends ConsumerWidget {
  const DepartmentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getDepartmentsProvider).when(
          data: (data) => data.isEmpty
              ? const Center(child: Text("No departments found"))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                        title: Text(data[i].name),
                        leading: const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(FluentIcons.edit_16_regular),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(FluentIcons.delete_16_regular),
                              onPressed: () {},
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
