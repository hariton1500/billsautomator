import 'package:shared_preferences/shared_preferences.dart';

//String get token1 => File('hide.log').readAsStringSync();
Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token') ?? '';
}

String? token;

saveToken(String tmpToken) {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString('token', tmpToken);
  });
}
