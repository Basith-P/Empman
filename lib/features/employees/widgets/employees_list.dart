import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeesList extends ConsumerWidget {
  const EmployeesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Employee $index'),
          subtitle: Text('Employee $index subtitle'),
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}
