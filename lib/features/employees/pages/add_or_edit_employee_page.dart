import 'package:empman/core/constants.dart';
import 'package:empman/core/utils/widgets/loaders.dart';
import 'package:empman/features/departments/providers.dart';
import 'package:empman/features/employees/models/employee.dart';
import 'package:empman/features/employees/providers.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddOrEditEmployeePage extends ConsumerStatefulWidget {
  const AddOrEditEmployeePage({super.key, this.employee});

  final Employee? employee;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddOrEditEmployeePageState();
}

class _AddOrEditEmployeePageState extends ConsumerState<AddOrEditEmployeePage> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dateOfJoiningController;

  DateTime _dateOfJoining = DateTime.now();
  String? _departmentId;
  bool isEligible = false;

  @override
  void initState() {
    super.initState();
    final employee = widget.employee;
    _nameController = TextEditingController(text: employee?.name);
    _emailController = TextEditingController(text: employee?.email);
    final dateOfJoining = employee != null
        ? DateTime.parse(employee.joiningDate!)
        : DateTime.now();
    _dateOfJoiningController =
        TextEditingController(text: DateFormat.yMMMMd().format(dateOfJoining));
    _dateOfJoining = dateOfJoining;
    isEligible = _dateOfJoining
        .isBefore(DateTime.now().subtract(const Duration(days: 5 * 365 + 1)));
    _departmentId = employee?.department?.id;
  }

  void onpressed() async {
    if (formKey.currentState!.validate()) {
      final employee = Employee(
        id: widget.employee?.id,
        name: _nameController.text,
        email: _emailController.text,
        joiningDate: DateFormat('yyyy-MM-dd').format(_dateOfJoining),
        isManager: widget.employee?.isManager ?? false,
      );
      bool isSucces = false;
      if (widget.employee != null) {
        isSucces =
            await ref.read(employeesControllerProvider.notifier).updateEmployee(
                  employee: employee,
                  departmentId: _departmentId!,
                );
      } else {
        isSucces =
            await ref.read(employeesControllerProvider.notifier).createEmployee(
                  employee: employee,
                  departmentId: _departmentId!,
                );
      }
      if (isSucces) {
        ref.refresh(getEmployeesProvider);
        Navigator.pop(context);
      }
    }
  }

  void promoteEmployee() async {
    final isSuccessful = await ref
        .read(employeesControllerProvider.notifier)
        .promoteEmployee(widget.employee!);
    if (isSuccessful) {
      ref.refresh(getEmployeesProvider);
      ref.refresh(getDepartmentsProvider);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(employeesControllerProvider);

    final employee = widget.employee;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.employee != null ? 'Edit' : 'Add'} Employee"),
        actions: widget.employee == null
            ? null
            : [
                IconButton(
                  onPressed: () async {
                    await ref
                        .read(employeesControllerProvider.notifier)
                        .deleteEmployee(widget.employee!.id!);
                    ref.refresh(getEmployeesProvider);
                    Navigator.pop(context);
                  },
                  icon: const Icon(FluentIcons.delete_24_regular),
                ),
              ],
      ),
      body: isLoading
          ? loaderPrimary
          : ref.watch(getDepartmentsProvider).when(
                data: (departments) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _nameController,
                                decoration: kinputDecoration.copyWith(
                                    labelText: "Name"),
                                enabled: !isLoading,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter a name";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _emailController,
                                decoration: kinputDecoration.copyWith(
                                    labelText: "Email"),
                                enabled: !isLoading,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter an email";
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: kinputDecoration.copyWith(
                                    labelText: "Date of Joining"),
                                enabled: !isLoading,
                                readOnly: true,
                                controller: _dateOfJoiningController,
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now(),
                                  );
                                  if (date != null) {
                                    setState(() {
                                      _dateOfJoining = date;
                                      _dateOfJoiningController.text =
                                          DateFormat.yMMMMd()
                                              .format(_dateOfJoining);
                                    });
                                  }
                                },
                              ),
                              DropdownButtonFormField(
                                decoration: kinputDecoration.copyWith(
                                  labelText: "Department",
                                ),
                                value: _departmentId,
                                items: departments
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.id,
                                        child: Text(e.name),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _departmentId = value.toString();
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select a department";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(height: 8.0),
                      if (isEligible && (!(employee?.isManager ?? false))) ...[
                        OutlinedButton(
                            onPressed: promoteEmployee,
                            child: const Text("Promote as Manager")),
                        const SizedBox(height: 8.0),
                      ],
                      FilledButton(
                          onPressed: onpressed, child: const Text("Save")),
                    ],
                  ),
                ),
                error: (e, st) =>
                    const Center(child: Text('Something went wrong')),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateOfJoiningController.dispose();
    super.dispose();
  }
}
