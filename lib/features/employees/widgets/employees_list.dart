import 'package:emplman/features/employees/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeesList extends ConsumerWidget {
  const EmployeesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getEmployeesProvider).when(
          data: (data) => data.isEmpty
              ? const Center(child: Text("No employees found"))
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(data[i].name),
                      subtitle: Text(data[i].email),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
