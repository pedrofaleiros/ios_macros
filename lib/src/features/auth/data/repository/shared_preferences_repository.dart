import 'package:ios_macros/src/utils/shared_preferences_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  Future<String> getToken() async {
    final shared = await SharedPreferences.getInstance();
    final token = shared.getString(SPK.USER_LOGGED_KEY);
    if (token == null) {
      throw SPException('Erro no shared preferences');
    }
    return token;
  }

  Future<void> setToken(String token) async {
    final shared = await SharedPreferences.getInstance();
    final res = await shared.setString(SPK.USER_LOGGED_KEY, token);
    if (res == false) {
      throw SPException('Erro no shared preferences');
    }
  }

  Future<void> logout() async {
    final shared = await SharedPreferences.getInstance();
    await shared.remove(SPK.USER_LOGGED_KEY);
  }
}

class SPException implements Exception {
  final String message;

  SPException(this.message);

  @override
  String toString() => message;
}
