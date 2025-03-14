import 'package:shared_preferences/shared_preferences.dart';

//String get token1 => File('hide.log').readAsStringSync();
Future<String> getToken({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

String? token, elbaToken;

saveToken({required String key, required String record}) async {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString(key, record);
  });
}

clearToken({required String key}) async {
  SharedPreferences.getInstance().then((prefs) {
    prefs.remove(key);
  });
}
