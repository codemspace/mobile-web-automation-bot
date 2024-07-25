import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    // image: "https://",
    image: "assets/images/blank_user.png",
    name: 'Test Test',
    nickname: 'test',
    email: 'test.test@gmail.com',
    phone: '+1 (208) 206-5039',
    dateOfBirth: '12/12/1995',
    nationality: 'Ukraine',
    gender: 'man',
    address: 'test',
    passport: 'test',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
