class UserModel {
  late String id;
  late String name;
  late String token;
  late String refresh;

  UserModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['data']['user_id'];
    name = jsonMap['data']['user_name'];
    token = jsonMap['token'];
    refresh = jsonMap['refresh'];
  }
}
