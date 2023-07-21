class BranchModel {
  late String id;
  late String name;
  late String address;
  late String phone;

  BranchModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['branch_id'];
    name = jsonMap['branch_name'];
    address = jsonMap['branch_address'];
    phone = jsonMap['branch_phone'];
  }
}

class Departement {
  late int id;
  late String name;

  Departement.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['department_id'];
    name = jsonMap['department_name'];
  }
}
