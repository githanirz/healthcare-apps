import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? idUser, username, email;

  Future<void> saveSession(
      int val, String id, String username, String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setString("id", id);
    pref.setString("username", username);
    pref.setString("email", email);
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.getInt("value");
    idUser = pref.getString("id");
    username = pref.getString("username");
    email = pref.getString("email");
    return value;
  }

  Future<void> updateUsername(String newUsername) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", newUsername);
  }

  Future clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

SessionManager session = SessionManager();
