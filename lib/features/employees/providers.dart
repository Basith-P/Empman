import 'package:empman/core/providers.dart';
import 'package:empman/features/employees/employees_controller.dart';
import 'package:empman/features/employees/models/employee.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final employeesControllerProvider =
    StateNotifierProvider<EmployeesController, bool>(
        (ref) => EmployeesController(ref.read(dioProvider)));

final getEmployeesProvider = FutureProvider<List<Employee>>((ref) async {
  final employeesController = ref.read(employeesControllerProvider.notifier);
  final employees = await employeesController.getEmployees();
  return employees;
});
