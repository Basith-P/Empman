import 'package:empman/core/providers.dart';
import 'package:empman/features/departments/departments_controller.dart';
import 'package:empman/features/departments/models/department.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final departmentsControllerProvider =
    StateNotifierProvider<DepartmentsController, bool>(
        (ref) => DepartmentsController(ref.read(dioProvider)));

final getDepartmentsProvider = FutureProvider<List<Department>>((ref) async {
  final departmentsController =
      ref.read(departmentsControllerProvider.notifier);
  final departments = await departmentsController.getDepartments();
  return departments;
});
