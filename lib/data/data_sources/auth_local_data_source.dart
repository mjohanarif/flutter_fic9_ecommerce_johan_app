import 'package:flutter_fic9_ecommerce_johan_app/data/models/responses/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  // save auth data
  Future<void> saveAuthData(AuthResponseModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'auth',
      model.toJson(),
    );
  }

  // remove auth data
  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(
      'auth',
    );
  }

  // get token
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(authJson);
    return authData.jwt ?? '';
  }

  // get user
  Future<User> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString('auth') ?? '';
    final authData = AuthResponseModel.fromJson(authJson);
    return authData.user!;
  }

  // check if user logged in
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final authJson = prefs.getString('auth') ?? '';
    return authJson.isNotEmpty;
  }
}
