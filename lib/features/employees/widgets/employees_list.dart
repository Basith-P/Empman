import 'package:empman/features/employees/pages/add_or_edit_employee_page.dart';
import 'package:empman/features/employees/providers.dart';
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
                    final subtitle =
                        '${(data[i].isManager ?? false) ? 'Manager of ' : ''}${data[i].department?.name}';
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                AddOrEditEmployeePage(employee: data[i]),
                          ),
                        );
                      },
                      title: Text(data[i].name),
                      subtitle: Text(subtitle),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
          error: (error, stackTrace) =>
              const Center(child: Text('Something went wrong')),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
  }
}
