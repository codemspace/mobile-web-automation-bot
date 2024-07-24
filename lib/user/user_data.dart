import 'dart:convert';

import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static User myUser = User(
    // image: "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
    image: "assets/images/blank_user.png",
    name: 'Test Test',
    nickname: 'asdf',
    email: 'test.test@gmail.com',
    phone: '(208) 206-5039',
    dateOfBirth: 'asdf',
    nationality: 'asdf',
    gender: 'asdf',
    address: 'asdf',
    passport: 'asdf',
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
