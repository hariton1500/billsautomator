import 'dart:convert';

import 'package:bills/Models/company.dart';
import 'package:shared_preferences/shared_preferences.dart';

Set<Company> companies = {};

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

saveCompanies() async {
  List<String> companiesJson = [];//List.from(companies.map((e) => jsonEncode(e)).toList());
  for (var element in companies) {
    print('encoding ${element.title}');
    try {
      companiesJson.add(jsonEncode(element.toJson()));
    } catch (e) {
      print('encoding error: $e');
    }
  }
  SharedPreferences.getInstance().then((prefs) {
    prefs.setStringList('companies', companiesJson);
  });
}

loadCompanies() async {
  SharedPreferences.getInstance().then((prefs) {
    List<String> companiesJson = prefs.getStringList('companies') ?? [];
    for (var element in companiesJson) {
      try {
        companies.add(Company.fromJson(jsonDecode(element)));
      } catch (e) {
        print('decoding error: $e');
      }
    }
  });
}
