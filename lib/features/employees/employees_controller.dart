import 'package:dio/dio.dart';
import 'package:emplman/core/endpoints.dart';
import 'package:emplman/features/employees/models/employee.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeesController extends StateNotifier<bool> {
  EmployeesController(this._dio) : super(false);

  final Dio _dio;

  Future<List<Employee>> getEmployees() async {
    try {
      final response = await _dio.get(Endpoints.employees);
      final data = response.data['data'] as List<dynamic>;
      final employees = data.map((e) => Employee.fromJson(e)).toList();
      return employees;
    } catch (e) {
      rethrow;
    }
  }

  Future<Employee> getEmployee(int id) async {
    try {
      state = true;
      final response = await _dio.get('${Endpoints.employees}/$id/');
      final data = response.data as Map<String, dynamic>;
      final employee = Employee.fromJson(data);
      return employee;
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<bool> createEmployee(Employee employee) async {
    bool isSuccessful = false;
    try {
      state = true;
      Map data = employee.toJson();
      data['department'] = employee.department?.id ?? 1;
      debugPrint(data.toString());
      await _dio.post(Endpoints.employees, data: data);
      isSuccessful = true;
    } catch (e) {
      debugPrint('=======> Error: $e');
    } finally {
      state = false;
    }
    return isSuccessful;
  }

  Future<void> updateEmployee(Employee employee) async {
    try {
      state = true;
      await _dio.put('${Endpoints.employees}/${employee.id}/',
          data: employee.toJson());
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<void> deleteEmployee(int id) async {
    try {
      state = true;
      await _dio.delete('${Endpoints.employees}/$id/');
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}
