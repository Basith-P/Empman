import 'package:empman/features/departments/models/department.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee.freezed.dart';
part 'employee.g.dart';

@freezed
class Employee with _$Employee {
  const factory Employee({
    String? id,
    @JsonKey(name: 'full_name') required String name,
    required String email,
    Department? department,
    @JsonKey(name: 'date_of_joining') String? joiningDate,
    @Default(false)
    @JsonKey(name: 'is_manager', defaultValue: false)
    bool? isManager,
  }) = _Employee;

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);
}
