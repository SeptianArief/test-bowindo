class Employee {
  late int id;
  late String name;
  late String address;
  late String dob;
  late String email;
  late int departementId;
  late int flagEmployee;
  late String branchId;
  late String branchName;
  late String departementName;

  Employee.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['employee_id'];
    name = jsonMap['employee_name'];
    address = jsonMap['employee_address'];
    dob = jsonMap['employee_dob'];
    email = jsonMap['employee_mail'];
    departementId = jsonMap['department_id'];
    flagEmployee = jsonMap['flag_employee'];
    branchId = jsonMap['branch_id'];
    branchName = jsonMap['branch_name'];
    departementName = jsonMap['department_name'];
  }
}
