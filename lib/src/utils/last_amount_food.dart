import 'package:shared_preferences/shared_preferences.dart';

class LastAmoutFood {
  String getKey(String foodId) {
    return "${foodId}qwertyuiop";
  }

  Future<double> getLastAmount(String foodId) async {
    final shared = await SharedPreferences.getInstance();

    final response = shared.getDouble(getKey(foodId));

    if (response != null) {
      return response;
    }

    return 100.0;
  }

  Future<void> setLastAmount(String foodId, double amount) async {
    final shared = await SharedPreferences.getInstance();

    await shared.setDouble(getKey(foodId), amount);
  }
}
