import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String id;
  final String password;
  final String name;

  User({required this.id, required this.password, required this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'password': password,
      'name': name,
    };
  }
}

class UserManager {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static void addUser(User user) {
    _prefs!.setString(user.id, user.password);
    _prefs!.setString('${user.id}_name', user.name);
  }

  static User? authenticate(String id, String password) {
    String? storedPassword = _prefs!.getString(id);
    if (storedPassword == password) {
      String? name = _prefs!.getString('${id}_name');
      if (name != null) {
        return User(id: id, password: password, name: name);
      }
    }
    return null;
  }

  static bool isUserExist(String id) {
    return _prefs!.getString(id) != null;
  }
}
