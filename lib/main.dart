import 'package:bills/Pages/mainpage.dart';
import 'package:bills/globals.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  token = await getToken(key: 'token');
  elbaToken = await getToken(key: 'albaToken');
  try {
    await loadCompanies();
  } catch (e) {
    print(e);
  }
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Mainpage(),
    );
  }
}
