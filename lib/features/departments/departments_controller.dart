import 'package:dio/dio.dart';
import 'package:emplman/core/endpoints.dart';
import 'package:emplman/core/utils/functions.dart';
import 'package:emplman/features/departments/models/department.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DepartmentsController extends StateNotifier<bool> {
  DepartmentsController(this._dio) : super(false);

  final Dio _dio;

  Future<List<Department>> getDepartments() async {
    try {
      final response = await _dio.get(Endpoints.departments);
      final data = response.data['data'] as List<dynamic>;
      final departments = data.map((e) => Department.fromJson(e)).toList();
      return departments;
    } catch (e) {
      debugPrint('=======> Error: $e');
      rethrow;
    }
  }

  Future<Department> getDepartment(int id) async {
    try {
      state = true;
      final response = await _dio.get('${Endpoints.departments}/$id/');
      final data = response.data['data'] as Map<String, dynamic>;
      final department = Department.fromJson(data);
      return department;
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<bool> createDepartment(Department department) async {
    bool isSuccessful = false;
    try {
      state = true;
      Map data = {"name": department.name};
      await _dio.post(Endpoints.departments, data: data);
      isSuccessful = true;
    } catch (e) {
      debugPrint('====> Error: $e');
      showSnackBar('Something went wrong, please try again later.');
    } finally {
      state = false;
    }
    return isSuccessful;
  }

  Future<void> updateDepartment(Department department) async {
    try {
      state = true;
      Map data = {"name": department.name};
      await _dio.put('${Endpoints.departments}/${department.id}/', data: data);
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }

  Future<void> deleteDepartment(Department dept) async {
    try {
      state = true;
      showSnackBar('Please wait...');
      await _dio.delete('${Endpoints.departments}/${dept.id}/');
      showSnackBar("Deleted '${dept.name}'");
    } catch (e) {
      rethrow;
    } finally {
      state = false;
    }
  }
}
